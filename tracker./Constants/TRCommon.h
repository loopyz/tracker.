//
//  Common.h
//  tracker.
//
//  Created by Niveditha Jayasekar on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRCommon : NSObject

#pragma mark - record of past periods
extern NSString *const kTRNumPeriodsKey;
extern NSString *const kTRPeriodDurationKey;
extern NSString *const kTRNoPeriodDurationKey;

#pragma mark - previous period
extern NSString *const kTRPreviousPeriodEndDateKey;

#pragma mark - current period
extern NSString *const kTRCurrentPeriodStartDateKey;

#pragma mark - next period predictions
extern NSString *const kTRNextPeriodStartDateKey;
extern NSString *const kTRNextPeriodDurationKey;

#pragma mark - notifications
extern NSString *const kTRPillAlarmToggleKey;
extern NSString *const kTRPillAlarmDataKey;
extern NSString *const kTRPillAlarmHourKey;

extern NSString *const kTRStartPeriodAlarmToggleKey;
extern NSString *const kTRStartPeriodAlarmDataKey;
extern NSString *const kTRStartPeriodAlarmHourKey;

@end
