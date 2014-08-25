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

#pragma mark - next period predictions
extern NSString *const kTRExpectedStartDateKey;
extern NSString *const kTRExpectedDurationKey;

#pragma mark - notifications
extern NSString *const kTRPillAlarmKey;
extern NSString *const kTRStartPeriodAlarmKey;

@end
