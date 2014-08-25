//
//  CustomeDatePicker.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "CustomDatePicker.h"


@interface CustomDatePicker ()
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *doneButton;
@end

@implementation CustomDatePicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self updateSubviews];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateSubviews];
}

- (void)updateSubviews
{
    
    self.navInputView.frame = CGRectMake(0, 0, self.frame.size.width, 45);
    self.cancelButton.frame = CGRectMake(5, 5, 80, 35);
    CGFloat width = 80;
    self.doneButton.frame = CGRectMake(CGRectGetMaxX(self.navInputView.frame) - width, self.cancelButton.frame.origin.y, width, self.cancelButton.frame.size.height);
}

- (UIView *)navInputView
{
    if (!_navInputView)
    {
        _navInputView = [[UIView alloc] init];
        _navInputView.backgroundColor = [UIColor whiteColor];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_navInputView addSubview:self.cancelButton];
        
        self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.doneButton setTitle:@"DONE" forState:UIControlStateNormal];
        [self.doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_navInputView addSubview:self.doneButton];
    }
    
    return _navInputView;
}

- (void)cancelButtonPressed
{
    [self.actionDelegate cancel:self];
}

- (void)doneButtonPressed
{
    [self.actionDelegate done:self];
}

@end
