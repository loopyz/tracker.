//
//  TRTodayPainView.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Ludo Labs, Inc. All rights reserved.
//

#import "TRTodayPainView.h"

@implementation TRTodayPainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [TRColors darkRed];
        self.headerLabel.text = @"Today's pain:";
        [self setIcon:[UIImage imageNamed:@"lightningicon.png"] withWidth:29 withHeight:44];
    }
    return self;
}

- (void)refreshView:(NSString *)pain
{
    if (pain == nil) {
        self.selectionLabel.text = @"Tap to set";
    } else {
        self.selectionLabel.text = pain;
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
