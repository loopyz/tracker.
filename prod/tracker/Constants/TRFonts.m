//
//  TRFonts.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Ludo Labs, Inc. All rights reserved.
//

#import "TRFonts.h"

@implementation TRFonts

+ (UIFont *)currentDayFont
{
    return [UIFont fontWithName:@"Avenir" size:26.0f];
}

+ (UIFont *)estimatedDaysLeftFont
{
    return [UIFont fontWithName:@"Avenir-Light" size:15.0f];
}

+ (UIFont *)daysUntilPeriodFont
{
    return [UIFont fontWithName:@"Avenir" size:18.0f];
}

+ (UIFont *)mainCategoryFont
{
    return [UIFont fontWithName:@"Avenir" size:22.0f];
}

+ (UIFont *)mainSelectionFont
{
    return [UIFont fontWithName:@"Avenir" size:18.0f];
}

@end
