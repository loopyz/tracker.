//
//  SettingsObject.m
//  tracker.
//
//  Created by Lucy Guo on 8/26/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "SettingsObject.h"

@implementation SettingsObject

@synthesize pillNotifDate, periodNotifOn, pillNotifOn, numDaysBeforePeriodNotif;

+ (id)settingsObject {
    SettingsObject *settingsObject = [[SettingsObject alloc] init];
    return settingsObject;
}



@end
