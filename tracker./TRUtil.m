//
//  TRUtil.m
//  tracker.
//
//  Created by Niveditha Jayasekar on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "TRUtil.h"

@implementation TRUtil

#pragma mark - helper methods (internal)
+ (void)removeLocalNotificationFromData:(NSData *)data
{
    if (data != nil) {
        UILocalNotification *localNotif = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"Remove localnotification %@", localNotif);
        [[UIApplication sharedApplication] cancelLocalNotification:localNotif];
    }
}

+ (NSDate *)convertDate:(NSDate *)date withHours:(NSInteger)hour
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger timeComps = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSTimeZoneCalendarUnit);
    NSDateComponents *comps = [calendar components:timeComps fromDate:date];
    [comps setHour:hour];
    [comps setMinute:0];
    [comps setSecond:0];
    return [calendar dateFromComponents:comps];
}

+ (NSData *)createLocalNotificationForDate:(NSDate *)date withText:(NSString *)text AndRepeating:(BOOL)repeating
{
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    [localNotif setTimeZone:[NSTimeZone defaultTimeZone]];
    [localNotif setFireDate:date];
    [localNotif setAlertBody:text];
    [localNotif setHasAction:NO];

    if (repeating) {
        [localNotif setRepeatInterval:NSDayCalendarUnit];
    }

    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
    return [NSKeyedArchiver archivedDataWithRootObject:localNotif];
}

#pragma mark - main methods
+ (NSInteger)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2
{
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:dt1 toDate:dt2 options:0];
    NSInteger daysBetween = abs([components day]);
    return daysBetween+1;
}

+ (BOOL)shouldAutoEndPeriod
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *startDate = [defaults objectForKey:kTRCurrentPeriodStartDateKey];
    
    return ((startDate != nil) && ([self daysBetween:startDate and:[NSDate date]] > kTRMaxPeriodDuration));
}

+ (NSDictionary *)computeFertility
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *fertility = @{@"state":@0, @"caption":@"N/A"};
    NSDate *todayDate = [NSDate date];
    
    NSDate *startDate = [defaults objectForKey:kTRCurrentPeriodStartDateKey];
    NSInteger duration = 0;
    
    return fertility;
}

+ (void)resetDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // set hasBeenLaunched
    [defaults setBool:YES forKey:kTRHasBeenLaunchedKey];

    // set up past records
    [defaults setInteger:0 forKey:kTRNumPeriodsKey];
    [defaults setInteger:0 forKey:kTRPeriodDurationKey];
    [defaults setInteger:0 forKey:kTRNoPeriodDurationKey];

    // clear previous, current, and next periods
    [defaults removeObjectForKey:kTRCurrentPeriodStartDateKey];
    [defaults removeObjectForKey:kTRCurrentPeriodFlowKey];
    [defaults removeObjectForKey:kTRCurrentPeriodPainKey];
    
    [defaults removeObjectForKey:kTRPreviousPeriodEndDateKey];
    [defaults removeObjectForKey:kTRPreviousPeriodFlowKey];
    [defaults removeObjectForKey:kTRPreviousPeriodPainKey];
    
    [defaults removeObjectForKey:kTRNextPeriodStartDateKey];
    [defaults removeObjectForKey:kTRNextPeriodDurationKey];

    // remove alarms
    NSData *startPeriodAlarmData = [defaults objectForKey:kTRStartPeriodAlarmDataKey];
    [self removeLocalNotificationFromData:startPeriodAlarmData];
    [defaults removeObjectForKey:kTRStartPeriodAlarmDataKey];
    
    NSData *pillAlarmData = [defaults objectForKey:kTRPillAlarmDataKey];
    [self removeLocalNotificationFromData:pillAlarmData];
    [defaults removeObjectForKey:kTRPillAlarmDataKey];
    
    // toggle alarms to off
    [defaults setBool:NO forKey:kTRStartPeriodAlarmToggleKey];
    [defaults setBool:NO forKey:kTRPillAlarmToggleKey];
    
    // reset alarm times to 9am
    [defaults setInteger:9 forKey:kTRStartPeriodAlarmHourKey];
    [defaults setInteger:9 forKey:kTRPillAlarmHourKey];
    
    [defaults synchronize];
}

+ (void)addCurrentPeriod:(NSDate *)startDate
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // get past records
    NSInteger noPeriodDuration = [defaults integerForKey:kTRNoPeriodDurationKey];

    // compute previous period values
    NSDate *endDate = [defaults objectForKey:kTRPreviousPeriodEndDateKey];
    NSInteger previousNoPeriodDuration = (endDate == nil) ? 0 : [self daysBetween:endDate and:startDate];
    
    // update past records
    [defaults setInteger:noPeriodDuration + previousNoPeriodDuration forKey:kTRNoPeriodDurationKey];
    
    // reset previous end date, store current start date
    [defaults setObject:startDate forKey:kTRCurrentPeriodStartDateKey];
    [defaults removeObjectForKey:kTRPreviousPeriodEndDateKey];
    
    // remove starting period alert if exists
    NSData *startPeriodAlarmData = [defaults objectForKey:kTRStartPeriodAlarmDataKey];
    [self removeLocalNotificationFromData:startPeriodAlarmData];
    [defaults removeObjectForKey:kTRStartPeriodAlarmDataKey];
    
    [defaults synchronize];
}

+ (void)addPastPeriod:(NSDate *)endDate
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // compute current period values
    NSDate *startDate = [defaults objectForKey:kTRCurrentPeriodStartDateKey];
    NSInteger currentPeriodDuration = (endDate == nil) ? 0 : [self daysBetween:startDate and:endDate];
    
    // get past records
    NSInteger numPeriods = [defaults integerForKey:kTRNumPeriodsKey] + 1;
    NSInteger periodDuration = [defaults integerForKey:kTRPeriodDurationKey] + currentPeriodDuration;
    NSInteger noPeriodDuration = [defaults integerForKey:kTRNoPeriodDurationKey];
    
    // handle cases where endDate is nil (autoending period)
    if (endDate == nil) {
        if (numPeriods == 1) { // first period - no past records
            periodDuration += kTRDefaultPeriodDuration;
            endDate = [startDate dateByAddingTimeInterval:kTRDefaultDayTimeInterval*kTRDefaultPeriodDuration];
        } else { //use avg of past records
            periodDuration += periodDuration/(numPeriods-1);
            endDate = [startDate dateByAddingTimeInterval:kTRDefaultDayTimeInterval*(periodDuration/(numPeriods - 1))];
        }
    }

    // update past records
    [defaults setInteger:periodDuration forKey:kTRPeriodDurationKey];
    [defaults setInteger:numPeriods forKey:kTRNumPeriodsKey];
    
    //store current period into previous period, reset current period
    [defaults setObject:endDate forKey:kTRPreviousPeriodEndDateKey];
    [defaults setObject:[defaults objectForKey:kTRCurrentPeriodFlowKey] forKey:kTRPreviousPeriodFlowKey];
    [defaults setObject:[defaults objectForKey:kTRCurrentPeriodPainKey] forKey:kTRPreviousPeriodPainKey];
    
    [defaults removeObjectForKey:kTRCurrentPeriodStartDateKey];
    [defaults removeObjectForKey:kTRCurrentPeriodFlowKey];
    [defaults removeObjectForKey:kTRCurrentPeriodPainKey];
    // remove old alarm in case
    NSData *startPeriodAlarmData = [defaults objectForKey:kTRStartPeriodAlarmDataKey];
    [self removeLocalNotificationFromData:startPeriodAlarmData];
    [defaults removeObjectForKey:kTRStartPeriodAlarmDataKey];
    
    // predict next period
    NSInteger startPeriodAlarmHour = [defaults integerForKey:kTRStartPeriodAlarmHourKey];
    NSInteger nextDuration = (periodDuration == 0) ? kTRDefaultPeriodDuration : periodDuration/numPeriods;
    NSInteger nextNoPeriodDuration = (noPeriodDuration == 0) ? kTRDefaultNoPeriodDuration : noPeriodDuration/numPeriods;
    NSDate *nextStartDate = [endDate dateByAddingTimeInterval:kTRDefaultDayTimeInterval*nextNoPeriodDuration];

    [defaults setObject:nextStartDate forKey:kTRNextPeriodStartDateKey];
    [defaults setInteger:nextDuration forKey:kTRNextPeriodDurationKey];
    
    // create starting period alert if starting period alarm is toggled on
    BOOL startPeriodAlarmToggle = [defaults boolForKey:kTRStartPeriodAlarmToggleKey];
    if (startPeriodAlarmToggle) {
        NSDate *fireDate = [self convertDate:nextStartDate withHours:startPeriodAlarmHour];
        startPeriodAlarmData = [self createLocalNotificationForDate:fireDate withText:kTRStartPeriodAlarmNotificationText AndRepeating:NO];
        [defaults setObject:startPeriodAlarmData forKey:kTRStartPeriodAlarmDataKey];
    }
    [defaults synchronize];
}

+ (void)setCurrentPeriodFlow:(NSString *)flow
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:flow forKey:kTRCurrentPeriodFlowKey];
    [defaults synchronize];
}

+ (void)setCurrentPeriodPain:(NSString *)pain
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:pain forKey:kTRCurrentPeriodPainKey];
    [defaults synchronize];
}

+ (void)setPillAlarm:(NSInteger)hour minute:(NSInteger)minute
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:YES forKey:kTRPillAlarmToggleKey];
    [defaults setInteger:hour forKey:kTRPillAlarmHourKey];

    // remove old local notification
    NSData *pillAlarmData = [defaults objectForKey:kTRPillAlarmDataKey];
    [self removeLocalNotificationFromData:pillAlarmData];
    
    // create fire date
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    [calendar setTimeZone:timeZone];
    
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit fromDate:currentDate];
    if ([components hour] > hour || (([components hour] == hour) && [components minute] >= minute)) { // make it the next day
        [components setDay:[components day] + 1 ];
    }
    [components setHour:hour];
    [components setMinute:minute];
    
    NSDate *fireDate = [calendar dateFromComponents:components];
    
    // create local notification
    pillAlarmData = [self createLocalNotificationForDate:fireDate withText:kTRPillAlarmNotificationText AndRepeating:YES];
    [defaults setObject:pillAlarmData forKey:kTRPillAlarmDataKey];
    
    [defaults synchronize];
}

+ (void)removePillAlarm
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:NO forKey:kTRPillAlarmToggleKey];
    
    // remove local notification if exists
    NSData *pillAlarmData = [defaults objectForKey:kTRPillAlarmDataKey];
    [self removeLocalNotificationFromData:pillAlarmData];
    [defaults removeObjectForKey:kTRPillAlarmDataKey];

    [defaults synchronize];
}

+ (void)setStartPeriodAlarm:(NSInteger)day hour:(NSInteger)hour
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:YES forKey:kTRPillAlarmToggleKey];
    [defaults setInteger:hour forKey:kTRPillAlarmHourKey];
    
    // remove old local notification
    NSData *startPeriodAlarmData = [defaults objectForKey:kTRStartPeriodAlarmDataKey];
    [self removeLocalNotificationFromData:startPeriodAlarmData];
    
    // create fire date
    NSDate *nextDate = [defaults objectForKey:kTRNextPeriodStartDateKey];
    NSDate *priorXTimeDate = [nextDate dateByAddingTimeInterval:-day*kTRDefaultDayTimeInterval];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    [calendar setTimeZone:timeZone];
    
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit fromDate:priorXTimeDate];
    [components setHour:hour];
    
    NSDate *fireDate = [calendar dateFromComponents:components];
    
    // create local notification
    startPeriodAlarmData = [self createLocalNotificationForDate:fireDate withText:kTRStartPeriodAlarmNotificationText AndRepeating:YES];
    [defaults setObject:startPeriodAlarmData forKey:kTRStartPeriodAlarmDataKey];
    
    [defaults synchronize];
}

+ (void)removeStartPeriodAlarm
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:NO forKey:kTRStartPeriodAlarmToggleKey];
    
    // remove local notification if exists
    NSData *startPeriodAlarmData = [defaults objectForKey:kTRStartPeriodAlarmDataKey];
    [self removeLocalNotificationFromData:startPeriodAlarmData];
    [defaults removeObjectForKey:kTRStartPeriodAlarmDataKey];
    
    [defaults synchronize];
}


@end
