//
//  SettingsForm.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FXForms.h"


typedef NS_ENUM(NSInteger, Gender)
{
    GenderMale = 0,
    GenderFemale,
    GenderOther
};

typedef NS_OPTIONS(NSInteger, PillNotifications)
{
    PillNotificationsOff = 0,
    PillNotificationsOn
};

typedef NS_OPTIONS(NSInteger, PeriodNotifications)
{
    PeriodNotificationsOff = 0,
    PeriodNotificationsOn
};


@interface SettingsForm : NSObject <FXForm>

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *repeatPassword;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) Gender gender;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, strong) NSDate *dateOfBirth;
@property (nonatomic, strong) UIImage *profilePhoto;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSArray *interests;
@property (nonatomic, copy) NSString *about;


@property (nonatomic, copy) NSString *notifications;
@property (nonatomic, assign) BOOL agreedToTerms;

@property (nonatomic, assign) PillNotifications pillNotif;
@property (nonatomic, assign) PeriodNotifications periodNotif;

@property (nonatomic, assign) NSUInteger daysBefore;

@property (nonatomic, assign) UISwitch *pillSwitch;
@property (nonatomic, assign) UISwitch *periodSwitch;


@end