//
//  TRSettingsObject.h
//  tracker.
//
//  Created by Lucy Guo on 8/26/14.
//  Copyright (c) 2014 Ludo Labs, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRSettingsObject : NSObject

@property (nonatomic, retain) NSDate *pillNotifDate;
@property (nonatomic, retain) NSNumber *periodNotifOn;
@property (nonatomic, retain) NSNumber *pillNotifOn;
@property (nonatomic, retain) NSNumber *numDaysBeforePeriodNotif;


+ (id)settingsObject;

@end
