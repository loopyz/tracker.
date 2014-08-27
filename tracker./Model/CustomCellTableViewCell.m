//
//  CustomCellTableViewCell.m
//  tracker.
//
//  Created by Lucy Guo on 8/27/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "CustomCellTableViewCell.h"

@implementation CustomCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView viewWithTag:1].frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
