//
//  TRSetTodaysFlowView.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "TRSetTodaysFlowView.h"

@implementation TRSetTodaysFlowView

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
    [lightButton addTarget:self action:@selector(lightButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"lightflowbutton.png"];
    [lightButton setImage:btnImage forState:UIControlStateNormal];
    lightButton.contentMode = UIViewContentModeScaleToFill;
    
    [self addSubview:lightButton];
    
    UIButton *mediumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    mediumButton.frame = CGRectMake(self.frame.size.width/2 - 94/2, 35, 94, 130);
    [mediumButton addTarget:self action:@selector(mediumButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"mediumflowbutton.png"];
    [mediumButton setImage:btnImage forState:UIControlStateNormal];
    mediumButton.contentMode = UIViewContentModeScaleToFill;
    
    [self addSubview:mediumButton];
    
    UIButton *heavyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    heavyButton.frame = CGRectMake(self.frame.size.width - 94 - 15, 35, 94, 130);
    [heavyButton addTarget:self action:@selector(heavyButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"heavyflowbutton.png"];
    [heavyButton setImage:btnImage forState:UIControlStateNormal];
    heavyButton.contentMode = UIViewContentModeScaleToFill;
    
    [self addSubview:heavyButton];
}

- (void)lightButtonTouched
{
    [TRUtil setCurrentPeriodFlow:kTRFlowLight];
    [self.delegate setLightFlow];
}

- (void)mediumButtonTouched
{
    [TRUtil setCurrentPeriodFlow:kTRFlowMedium];
    [self.delegate setMediumFlow];
}

- (void)heavyButtonTouched
{
    [TRUtil setCurrentPeriodFlow:kTRFlowHeavy];
    [self.delegate setHeavyFlow];
}

@end
