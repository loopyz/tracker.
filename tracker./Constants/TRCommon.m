//
//  Common.m
//  tracker.
//
//  Created by Niveditha Jayasekar on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "TRCommon.h"

@implementation TRCommon

#pragma mark - record of past periods
NSString *const kTRNumPeriodsKey = @"numPeriods";
NSString *const kTRPeriodDurationKey = @"periodDuration";
NSString *const kTRNoPeriodDurationKey = @"noPeriodDuration";

#pragma mark - next period predictions
NSString *const kTRExpectedStartDateKey = @"expectedStartDate";
NSString *const kTRExpectedDurationKey = @"expectedDuration";

#pragma mark - notifications
NSString *const kTRPillAlarmKey = @"pillAlarm";
NSString *const kTRStartPeriodAlarmKey = @"startPeriodAlarm";

@end
