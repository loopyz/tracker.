//
//  TRStartEndPeriod.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Ludo Labs, Inc. All rights reserved.
//

#import "TRStartEndPeriod.h"

static const int kStatusViewHeight = 52;

@implementation TRStartEndPeriod

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [TRColors mainColor];
        [self setupTextLabel];
    }
    return self;
}

- (void)setupTextLabel
{
    self.status = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kStatusViewHeight)];
    self.status.textAlignment = NSTextAlignmentCenter;
    [self.status setFont:[UIFont fontWithName:@"Avenir" size:22.0f]];
    [self.status setTextColor:[UIColor whiteColor]];
    [self addSubview:self.status];
}

- (void)refreshView:(BOOL)periodStarted
{
    if (periodStarted) {
        self.status.text = @"Tap to end period";
        self.backgroundColor = [TRColors endPeriodColor];
    } else {
        self.status.text = @"Tap to start period";
        self.backgroundColor = [TRColors mainColor];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
