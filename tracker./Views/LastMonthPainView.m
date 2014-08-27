//
//  LastMonthPainView.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "LastMonthPainView.h"
#import "Colors.h"

@implementation LastMonthPainView

- (id)initWithFrame:(CGRect)frame withPain:(NSString *)pain
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [Colors lightRed];
        self.headerLabel.text = @"Last month's pain:";
        self.selectionLabel.text = pain;
        [self setIcon:[UIImage imageNamed:@"lightningicon.png"] withWidth:29 withHeight:44];
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
