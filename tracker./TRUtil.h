//
//  TRUtil.h
//  tracker.
//
//  Created by Niveditha Jayasekar on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRUtil : NSObject

+ (NSInteger)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2;

+ (BOOL)shouldAutoEndPeriod;
+ (NSDictionary *)computeFertility;

+ (void)resetDefaults;

+ (void)addCurrentPeriod:(NSDate *)startDate;
+ (void)addPastPeriod:(NSDate *)endDate;

+ (void)setCurrentPeriodFlow:(NSString *)flow;
+ (void)setCurrentPeriodPain:(NSString *)pain;

+ (void)setPillAlarm:(NSInteger)hour minute:(NSInteger)minute;
+ (void)removePillAlarm;

+ (void)setStartPeriodAlarm:(NSInteger)day hour:(NSInteger)hour;
+ (void)removeStartPeriodAlarm;

+ (NSData *)createLocalNotificationForDate:(NSDate *)date withText:(NSString *)text AndRepeating:(BOOL)repeating;

@end
