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

- (id)initWithFrame:(CGRect)frame withFlow:(NSString *)flow
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [Colors lightBlue];
        self.headerLabel.text = @"Last month's flow:";
        self.selectionLabel.text = flow;
        [self setIcon:[UIImage imageNamed:@"raindropicon.png"]];
    }
    return self;
}

@end
