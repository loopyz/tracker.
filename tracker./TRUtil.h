//
//  TRUtil.h
//  tracker.
//
//  Created by Niveditha Jayasekar on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRUtil : NSObject

+ (void)resetDefaults;

+ (void)addCurrentPeriod:(NSDate *)startDate;
+ (void)addPastPeriod:(NSDate *)endDate;

+ (void)setCurrentPeriodFlow:(NSString *)flow;
+ (void)setCurrentPeriodPain:(NSString *)pain;

+ (NSInteger)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2;

@end
