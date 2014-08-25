//
//  RegularCellView.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegularCellView : UIView

@property (strong, nonatomic) UILabel *headerLabel;
@property (strong, nonatomic) UILabel *selectionLabel;

- (void)setIcon:(UIImage *)iconImage;

@end
