//
//  StartEndPeriod.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartEndPeriod : UIView
@property UILabel *status;
- (void)refreshView:(BOOL)periodStarted;
@end