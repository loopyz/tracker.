//
//  Common.h
//  tracker.
//
//  Created by Niveditha Jayasekar on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRCommon : NSObject

#pragma mark - basic
extern NSString *const kTRHasBeenLaunchedKey;

#pragma mark - default period data
extern const int kTRDefaultPeriodDuration;
extern const int kTRDefaultNoPeriodDuration;
extern const int kTRDefaultAlertHour;
extern const int kTRDefaultDayTimeInterval;
extern const int kTRMaxPeriodDuration;

#pragma mark - levels
extern NSString *const kTRPainLow;
extern NSString *const kTRPainMedium;
extern NSString *const kTRPainHigh;
extern NSString *const kTRFlowLight;
extern NSString *const kTRFlowMedium;
extern NSString *const kTRFlowHeavy;

#pragma mark - record of past periods
extern NSString *const kTRNumPeriodsKey;
extern NSString *const kTRPeriodDurationKey;
extern NSString *const kTRNoPeriodDurationKey;

#pragma mark - previous period
extern NSString *const kTRPreviousPeriodEndDateKey;
extern NSString *const kTRPreviousPeriodFlowKey;
extern NSString *const kTRPreviousPeriodPainKey;

#pragma mark - current period
extern NSString *const kTRCurrentPeriodStartDateKey;
extern NSString *const kTRCurrentPeriodFlowKey;
extern NSString *const kTRCurrentPeriodPainKey;

#pragma mark - next period predictions
extern NSString *const kTRNextPeriodStartDateKey;
extern NSString *const kTRNextPeriodDurationKey;

#pragma mark - notifications
extern NSString *const kTRPillAlarmToggleKey;
extern NSString *const kTRPillAlarmDataKey;
extern NSString *const kTRPillAlarmHourKey;
extern NSString *const kTRPillAlarmNotificationText;

extern NSString *const kTRStartPeriodAlarmToggleKey;
extern NSString *const kTRStartPeriodAlarmDataKey;
extern NSString *const kTRStartPeriodAlarmHourKey;
extern NSString *const kTRStartPeriodAlarmNotificationText;

@end
