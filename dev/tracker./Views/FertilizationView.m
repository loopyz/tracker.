//
//  FertilizationView.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "FertilizationView.h"
#import "Colors.h"
#import "Fonts.h"

@interface FertilizationView() {
    UILabel *statusLabel;
    UILabel *dateLabel;
}

@end

@implementation FertilizationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupIcon];
        [self setupLabelAttributes];
    }
    return self;
}

- (void)refreshView:(NSMutableDictionary *)fertility
{
    NSNumber *fertilizationState = [fertility objectForKey:@"state"];
    NSString *caption = [fertility objectForKey:@"caption"];

    [self setupBackgroundColor:[fertilizationState intValue]];
    [self setupStatus:[fertilizationState intValue] andCaption:caption];
}

- (void)setupIcon
{
    UIImageView *eggIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 38, 38)];
    eggIcon.image = [UIImage imageNamed:@"eggicon.png"];
    [self addSubview:eggIcon];

}

- (void)setupBackgroundColor:(int)fertilizationChance
{
    switch (fertilizationChance) {
        case 1:
            self.backgroundColor = [Colors lightGreen];
            break;
            
        case 2:
            self.backgroundColor = [Colors lightOrange];
            break;
            
        case 3:
            self.backgroundColor = [Colors lightRed];
            break;
            
        default:
            self.backgroundColor = [UIColor darkGrayColor];
            break;
    }
}

- (void)setupLabelAttributes
{
    statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, self.frame.size.width, self.frame.size.height/1.5f)];
    statusLabel.textColor = [UIColor whiteColor];
    statusLabel.font = [Fonts mainCategoryFont];
    [self addSubview:statusLabel];
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 70, self.frame.size.width, self.frame.size.height - statusLabel.frame.size.height - 70)];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.font = [Fonts estimatedDaysLeftFont];
    [self addSubview:dateLabel];
}

- (void)setupStatus:(int)fertilizationChance andCaption:(NSString *)caption
{
    switch (fertilizationChance) {
        case 1:
            statusLabel.text = @"Low pregnancy chance.";
            break;
            
        case 2:
            statusLabel.text = @"Mid pregnancy chance";
            break;
            
        case 3:
            statusLabel.text = @"High pregnancy chance";
            break;
            
        default:
            statusLabel.text = @"Pregnancy chance";
            break;
    }
    dateLabel.text = caption;
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
