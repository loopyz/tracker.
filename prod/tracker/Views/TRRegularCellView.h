//
//  TRRegularCellView.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Ludo Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRRegularCellView : UIView

@property (strong, nonatomic) UILabel *headerLabel;
@property (strong, nonatomic) UILabel *selectionLabel;
@property (strong, nonatomic) UIImageView *iconView;

- (void)setIcon:(UIImage *)iconImage withWidth:(NSUInteger)width withHeight:(NSUInteger)height;

@end
