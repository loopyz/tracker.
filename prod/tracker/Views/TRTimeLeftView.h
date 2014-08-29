//
//  TRTimeLeftView.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRTimeLeftView : UIView

@property NSUInteger daysLeft;
@property NSUInteger currentDay;
@property NSUInteger daysUntilPeriod;

- (void)setupCurrentDayOfPeriod:(NSUInteger)currentDay;
- (void)setupDaysLeftTillEnd:(NSUInteger)daysLeft;
- (void)setupDaysUntilPeriod:(NSUInteger)daysUntilPeriod;
- (void)setupNoPreviousData;
- (void)refreshView:(NSInteger)currentDay remaining:(NSInteger)remaining;
@end
