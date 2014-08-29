//
//  TRSettingsObject.m
//  tracker.
//
//  Created by Lucy Guo on 8/26/14.
//  Copyright (c) 2014 Ludo Labs, Inc. All rights reserved.
//

#import "TRSettingsObject.h"

@implementation TRSettingsObject

@synthesize pillNotifDate, periodNotifOn, pillNotifOn, numDaysBeforePeriodNotif;

+ (id)settingsObject {
    TRSettingsObject *settingsObject = [[TRSettingsObject alloc] init];
    return settingsObject;
}

@end
