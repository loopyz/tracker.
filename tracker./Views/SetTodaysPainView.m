//
//  SetTodaysPainView.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "SetTodaysPainView.h"

@implementation SetTodaysPainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 2;
        self.layer.masksToBounds = YES;
        [self setupButtons];
    }
    return self;
}

- (void)setupButtons
{
    UIButton *lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    lightButton.frame = CGRectMake(15, 35, 94, 130);
    [lightButton addTarget:self action:@selector(lowPainButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"lowpainbutton.png"];
    [lightButton setImage:btnImage forState:UIControlStateNormal];
    lightButton.contentMode = UIViewContentModeScaleToFill;
    
    [self addSubview:lightButton];
    
    UIButton *mediumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    mediumButton.frame = CGRectMake(self.frame.size.width/2 - 94/2, 35, 94, 130);
    [mediumButton addTarget:self action:@selector(mediumPainButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"mediumpainbutton.png"];
    [mediumButton setImage:btnImage forState:UIControlStateNormal];
    mediumButton.contentMode = UIViewContentModeScaleToFill;
    
    [self addSubview:mediumButton];
    
    UIButton *heavyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    heavyButton.frame = CGRectMake(self.frame.size.width - 94 - 15, 35, 94, 130);
    [heavyButton addTarget:self action:@selector(highPainButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"highpainbutton.png"];
    [heavyButton setImage:btnImage forState:UIControlStateNormal];
    heavyButton.contentMode = UIViewContentModeScaleToFill;
    
    [self addSubview:heavyButton];
}

- (void)lowPainButtonTouched
{
    [self.delegate setLowPain];
}

- (void)mediumPainButtonTouched
{
    [self.delegate setMediumPain];
}

- (void)highPainButtonTouched
{
    [self.delegate setHighPain];
}
@end
