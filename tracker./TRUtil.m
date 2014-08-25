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
- (void)removeLocalNotificationFromData:(NSData *)data
{
    if (data != nil) {
        UILocalNotification *localNotif = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"Remove localnotification %@", localNotif);
        [[UIApplication sharedApplication] cancelLocalNotification:localNotif];
    }
}

- (NSInteger)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2
{
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:dt1 toDate:dt2 options:0];
    NSInteger daysBetween = abs([components day]);
    return daysBetween+1;
}

- (NSDate *)convertDate:(NSDate *)date withHours:(NSInteger)hour
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger timeComps = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSTimeZoneCalendarUnit);
    NSDateComponents *comps = [calendar components:timeComps fromDate:date];
    [comps setHour:hour];
    [comps setMinute:0];
    [comps setSecond:0];
    return [calendar dateFromComponents:comps];
}

#pragma mark - main methods
- (void)resetDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // set up past records
    [defaults setInteger:0 forKey:kTRNumPeriodsKey];
    [defaults setInteger:0 forKey:kTRPeriodDurationKey];
    [defaults setInteger:0 forKey:kTRNoPeriodDurationKey];

    // clear previous and current periods
    [defaults removeObjectForKey:kTRCurrentPeriodStartDateKey];
    [defaults removeObjectForKey:kTRPreviousPeriodEndDateKey];
    
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
    
    [defaults synchronize];
}

- (void)addCurrentPeriod:(NSDate *)startDate
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // get past records
    NSInteger noPeriodDuration = [defaults integerForKey:kTRNoPeriodDurationKey];

    // compute previous period values
    NSDate *endDate = [defaults objectForKey:kTRPreviousPeriodEndDateKey];
    NSInteger previousNoPeriodDuration = [self daysBetween:endDate and:startDate];
    
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

- (void)addPastPeriod:(NSDate *)endDate
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // get past records
    NSInteger periodDuration = [defaults integerForKey:kTRPeriodDurationKey];
    NSInteger noPeriodDuration = [defaults integerForKey:kTRNoPeriodDurationKey];
    NSInteger numPeriods = [defaults integerForKey:kTRNumPeriodsKey];
    
    // compute current period values
    NSDate *startDate = [defaults objectForKey:kTRCurrentPeriodStartDateKey];
    NSInteger currentPeriodDuration = [self daysBetween:startDate and:endDate];
    
    // update past records
    [defaults setInteger:periodDuration + currentPeriodDuration forKey:kTRPeriodDurationKey];
    [defaults setInteger:numPeriods + 1 forKey:kTRNumPeriodsKey];
    
    // reset current start date, store current end date
    [defaults removeObjectForKey:kTRCurrentPeriodStartDateKey];
    [defaults setObject:endDate forKey:kTRPreviousPeriodEndDateKey];
    
    // remove old alarm in case
    NSData *startPeriodAlarmData = [defaults objectForKey:kTRStartPeriodAlarmDataKey];
    [self removeLocalNotificationFromData:startPeriodAlarmData];
    [defaults removeObjectForKey:kTRStartPeriodAlarmDataKey];
    
    // predict next period and create starting period alert if starting period alarm is toggled on
    BOOL startPeriodAlarmToggle = [defaults boolForKey:kTRStartPeriodAlarmToggleKey];

    if (startPeriodAlarmToggle) {
        NSInteger startPeriodAlarmHour = [defaults integerForKey:kTRStartPeriodAlarmHourKey];
        NSInteger nextDuration = (numPeriods == 0) ? 8 : periodDuration/numPeriods;
        nextDuration = (nextDuration == 0) ? 8 : nextDuration;
        NSInteger nextNoPeriodDuration = noPeriodDuration/numPeriods;
    
        NSDate *nextStartDate = [endDate dateByAddingTimeInterval:60*60*24*nextNoPeriodDuration];
        
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        [localNotif setTimeZone:[NSTimeZone defaultTimeZone]];
        [localNotif setFireDate:[self convertDate:nextStartDate withHours:startPeriodAlarmHour]];
        [localNotif setAlertBody:@"Has your period started yet? Check in with Tracker."];
        [localNotif setHasAction:NO];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
        
        startPeriodAlarmData = [NSKeyedArchiver archivedDataWithRootObject:localNotif];
        [defaults setObject:startPeriodAlarmData forKey:kTRStartPeriodAlarmDataKey];
    }
    [defaults synchronize];
}

@end
