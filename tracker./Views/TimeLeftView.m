//
//  TimeLeftView.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "TimeLeftView.h"
#import "Colors.h"
#import "Fonts.h"

@interface TimeLeftView() {
    UILabel *currentDayLabel;
    UILabel *daysLeftTillEndLabel;
    UILabel *daysUntilPeriodLabel;
    UILabel *untilPeriod;
}

@end

@implementation TimeLeftView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [Colors daysLeftColor];
        [self setupClockIcon];
        [self setupLabelAttributes];
        daysLeftTillEndLabel.hidden = YES;
        currentDayLabel.hidden = YES;
        daysUntilPeriodLabel.hidden = YES;
        untilPeriod.hidden = YES;
    }
    return self;
}

- (void)setupLabelAttributes
{
    currentDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, self.frame.size.width, self.frame.size.height/1.5f)];
    currentDayLabel.textColor = [Colors grayFontColor];
    currentDayLabel.font = [Fonts currentDayFont];
    [self addSubview:currentDayLabel];
    
    daysLeftTillEndLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 70, self.frame.size.width, self.frame.size.height - currentDayLabel.frame.size.height - 70)];
    daysLeftTillEndLabel.textColor = [Colors grayFontColor];
    daysLeftTillEndLabel.font = [Fonts estimatedDaysLeftFont];
    [self addSubview:daysLeftTillEndLabel];
    
    daysUntilPeriodLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, self.frame.size.width, self.frame.size.height/1.5f)];
    daysUntilPeriodLabel.textColor = [Colors grayFontColor];
    daysUntilPeriodLabel.font = [Fonts daysUntilPeriodFont];
    [self addSubview:daysUntilPeriodLabel];
    
    untilPeriod = [[UILabel alloc] initWithFrame:CGRectMake(70, 70, self.frame.size.width, self.frame.size.height - currentDayLabel.frame.size.height - 70)];
    untilPeriod.textColor = [Colors grayFontColor];
    untilPeriod.font = [Fonts daysUntilPeriodFont];
    untilPeriod.text = @"until next period.";
    [self addSubview:untilPeriod];
}

- (void)setupClockIcon
{
    UIImageView *clockIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 38, 38)];
    clockIcon.image = [UIImage imageNamed:@"clockicon.png"];
    [self addSubview:clockIcon];
}

- (void)setupCurrentDayOfPeriod:(NSUInteger)currentDay
{
    self.currentDay = currentDay;
    currentDayLabel.text = [NSString stringWithFormat:@"Day %d", currentDay];
    currentDayLabel.hidden = NO;
    daysUntilPeriodLabel.hidden = YES;
}

- (void)setupDaysLeftTillEnd:(NSUInteger)daysLeft
{
    self.daysLeft = daysLeft;
    daysLeftTillEndLabel.text = [NSString stringWithFormat:@"Estimated %d days left until end.", daysLeft];
    daysLeftTillEndLabel.hidden = NO;
    daysUntilPeriodLabel.hidden = YES;
    untilPeriod.hidden = YES;
}

- (void)setupDaysUntilPeriod:(NSUInteger)daysUntilPeriod
{
    self.daysUntilPeriod = daysUntilPeriod;
    daysUntilPeriodLabel.text = [NSString stringWithFormat:@"Estimated %d days", daysUntilPeriod];
    currentDayLabel.hidden = YES;
    daysLeftTillEndLabel.hidden = YES;
    daysUntilPeriodLabel.hidden = NO;
    untilPeriod.hidden = NO;
    daysUntilPeriodLabel.frame = CGRectMake(70, 0, self.frame.size.width, self.frame.size.height/1.5f);
}

- (void)setupNoPreviousData
{
    daysUntilPeriodLabel.text = @"Welcome to tracker.";
    currentDayLabel.hidden = YES;
    daysLeftTillEndLabel.hidden = NO;
    daysLeftTillEndLabel.text = @"Start your period to collect data";
    daysUntilPeriodLabel.hidden = NO;
    untilPeriod.hidden = YES;
    // daysUntilPeriodLabel.frame = CGRectMake(70, 0, self.frame.size.width, self.frame.size.height);
}

- (void)refreshView:(NSInteger)currentDay remaining:(NSInteger)remaining
{
    if ((currentDay == 0) && (remaining == 0)) { // first time using app
        [self setupNoPreviousData];
    } else if (currentDay == 0) { // period hasn't started yet
        [self setupDaysUntilPeriod:remaining];
    } else { // period has started
        [self setupCurrentDayOfPeriod:currentDay];
        [self setupDaysLeftTillEnd:remaining];
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
