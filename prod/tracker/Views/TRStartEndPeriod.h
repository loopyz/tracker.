//
//  TRStartEndPeriod.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Ludo Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRStartEndPeriod : UIView
@property UILabel *status;
- (void)refreshView:(BOOL)periodStarted;
@end
