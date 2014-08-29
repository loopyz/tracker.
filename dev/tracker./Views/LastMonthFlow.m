//
//  LastMonthFlow.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "LastMonthFlow.h"
#import "Colors.h"

@implementation LastMonthFlow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [Colors lightBlue];
        self.headerLabel.text = @"Last month's flow:";
        [self setIcon:[UIImage imageNamed:@"raindropicon.png"] withWidth:24 withHeight:36];
    }
    return self;
}

- (void)refreshView:(NSString *)flow
{
    if (flow == nil) {
        self.selectionLabel.text = @"N/A";
    } else {
        self.selectionLabel.text = flow;
    }
}

@end
