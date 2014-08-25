//
//  ThisMonthFlowView.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "TodayFlowView.h"
#import "Colors.h"

@implementation TodayFlowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [Colors lightBlue];
        self.headerLabel.text = @"Today month's flow:";
        self.selectionLabel.text = @"Tap to set";
        [self setIcon:[UIImage imageNamed:@"raindropicon.png"]];
    }
    return self;
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
