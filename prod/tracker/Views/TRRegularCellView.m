//
//  TRRegularCellView.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "TRRegularCellView.h"

@implementation TRRegularCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupLabels];
    }
    return self;
}

- (void)setupLabels
{
    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, self.frame.size.width, self.frame.size.height/1.5f)];
    self.headerLabel.font = [TRFonts mainCategoryFont];
    self.headerLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.headerLabel];
    
    self.selectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 70, self.frame.size.width, self.frame.size.height - self.headerLabel.frame.size.height - 70)];
    self.selectionLabel.font = [TRFonts mainSelectionFont];
    self.selectionLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.selectionLabel];
}

- (void)setIcon:(UIImage *)iconImage withWidth:(NSUInteger)width withHeight:(NSUInteger)height
{
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 15, width, height)];
    self.iconView.image = iconImage;
    [self addSubview:self.iconView];
}

@end
