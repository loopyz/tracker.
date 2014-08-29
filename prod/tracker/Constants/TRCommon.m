//
//  TRCommon.m
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
const int kTRDefaultAlertHour = 9;
const int kTRDefaultDayTimeInterval = 60*60*24;
const int kTRMaxPeriodDuration = 14;

#pragma mark - levels
NSString *const kTRPainLow = @"Low";
NSString *const kTRPainMedium = @"Medium";
NSString *const kTRPainHigh = @"High";
NSString *const kTRFlowLight = @"Light";
NSString *const kTRFlowMedium = @"Medium";
NSString *const kTRFlowHeavy = @"Heavy";

#pragma mark - record of past periods
NSString *const kTRNumPeriodsKey = @"numPeriods";
NSString *const kTRPeriodDurationKey = @"periodDuration";
NSString *const kTRNoPeriodDurationKey = @"noPeriodDuration";

#pragma mark - previous period
NSString *const kTRPreviousPeriodEndDateKey = @"previousPeriodEndDate";
NSString *const kTRPreviousPeriodFlowKey = @"previousPeriodFlow";
NSString *const kTRPreviousPeriodPainKey = @"previousPeriodPain";

#pragma mark - current period
NSString *const kTRCurrentPeriodStartDateKey = @"currentPeriodStartDate";
NSString *const kTRCurrentPeriodFlowKey = @"currentPeriodFlow";
NSString *const kTRCurrentPeriodPainKey = @"currentPeriodPain";

#pragma mark - next period predictions
NSString *const kTRNextPeriodStartDateKey = @"nextPeriodStartDate";
NSString *const kTRNextPeriodDurationKey = @"nextPeriodDuration";

#pragma mark - notifications
NSString *const kTRPillAlarmToggleKey = @"pillAlarmToggle";
NSString *const kTRPillAlarmDataKey = @"pillAlarmData";
NSString *const kTRPillAlarmHourKey = @"pillAlarmHour";
NSString *const kTRPillAlarmNotificationText = @"Don't forget to take your daily birth pill! - Tracker.";

NSString *const kTRStartPeriodAlarmToggleKey = @"startPeriodAlarmToggle";
NSString *const kTRStartPeriodAlarmDataKey = @"startPeriodAlarmData";
NSString *const kTRStartPeriodAlarmHourKey = @"startPeriodAlarmHour";
NSString *const kTRStartPeriodAlarmNotificationText = @"Has your period started yet? Check in with Tracker.";

@end
