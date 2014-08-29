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
        self.backgroundColor = [Colors darkBlue];
        self.headerLabel.text = @"Today's flow:";
        [self setIcon:[UIImage imageNamed:@"raindropicon.png"] withWidth:24 withHeight:36];
    }
    return self;
}

- (void)refreshView:(NSString *)flow
{
    if (flow == nil) {
        self.selectionLabel.text = @"Tap to set";
    } else {
        self.selectionLabel.text = flow;
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
