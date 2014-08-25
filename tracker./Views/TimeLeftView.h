//
//  TimeLeftView.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLeftView : UIView

@property NSUInteger daysLeft;
@property NSUInteger currentDay;
@property NSUInteger daysUntilPeriod;



- (id)initWithFrame:(CGRect)frame isOnPeriod:(BOOL)onPeriod;
- (void)setupCurrentDayOfPeriod:(NSUInteger)currentDay;
- (void)setupDaysLeftTillEnd:(NSUInteger)daysLeft;
- (void)setupDaysUntilPeriod:(NSUInteger)daysUntilPeriod;
@end
