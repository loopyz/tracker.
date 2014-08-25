//
//  Common.m
//  tracker.
//
//  Created by Niveditha Jayasekar on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "TRCommon.h"

@implementation TRCommon

#pragma mark - basic
NSString *const kTRHasBeenLaunchedKey = @"hasBeenLaunched";

#pragma mark - default period data
const int kTRDefaultPeriodDuration = 7;
const int kTRDefaultNoPeriodDuration = 28;

#pragma mark - record of past periods
NSString *const kTRNumPeriodsKey = @"numPeriods";
NSString *const kTRPeriodDurationKey = @"periodDuration";
NSString *const kTRNoPeriodDurationKey = @"noPeriodDuration";

#pragma mark - previous period
NSString *const kTRPreviousPeriodEndDateKey = @"previousPeriodEndDate";

#pragma mark - current period
NSString *const kTRCurrentPeriodStartDateKey = @"currentPeriodStartDate";

#pragma mark - next period predictions
NSString *const kTRNextPeriodStartDateKey = @"nextPeriodStartDate";
NSString *const kTRNextPeriodDurationKey = @"nextPeriodDuration";

#pragma mark - notifications
NSString *const kTRPillAlarmToggleKey = @"pillAlarmToggle";
NSString *const kTRPillAlarmDataKey = @"pillAlarmData";
NSString *const kTRPillAlarmHourKey = @"pillAlarmHour";

NSString *const kTRStartPeriodAlarmToggleKey = @"startPeriodAlarmToggle";
NSString *const kTRStartPeriodAlarmDataKey = @"startPeriodAlarmData";
NSString *const kTRStartPeriodAlarmHourKey = @"startPeriodAlarmHour";
NSString *const kTRStartPeriodAlarmNotificationText = @"Has your period started yet? Check in with Tracker.";

@end
