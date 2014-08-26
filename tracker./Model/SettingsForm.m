//
//  SettingsForm.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "SettingsForm.h"

@implementation SettingsForm

//because we want to rearrange how this form
//is displayed, we've implemented the fields array
//which lets us dictate exactly which fields appear
//and in what order they appear


- (NSArray *)fields
{
    return @[
             
             @{ FXFormFieldHeader: @"Pill Notifications",
                FXFormFieldKey: @"pillSwitch",
                FXFormFieldTitle: @"Pill Notification",
               FXFormFieldCell:[FXFormSwitchCell class]},

             @{ FXFormFieldTitle : @"Time",
                FXFormFieldCell:[FXFormDatePickerCell class]
                },
             
             @{ FXFormFieldHeader: @"Period Notifications",
                FXFormFieldKey: @"periodNotif",
                FXFormFieldTitle: @"Period Notification",
                FXFormFieldCell:[FXFormSwitchCell class]},
             
             
             @{FXFormFieldKey: @"daysBefore", FXFormFieldCell: [FXFormStepperCell class]},
             
             
             
             //this field doesn't correspond to any property of the form
             //it's just an action button. the action will be called on first
             //object in the responder chain that implements the submitForm
             //method, which in this case would be the AppDelegate
             
             @{FXFormFieldTitle: @"Save Settings", FXFormFieldHeader: @"", FXFormFieldAction: @"saveSettings:"},
             
             @{FXFormFieldTitle: @"Clear Data", FXFormFieldHeader: @"", FXFormFieldAction: @"clearData"},
             
             ];
}

- (UISwitch *)setOn:(UISwitch *)uiSwitch{
    [uiSwitch setOn:YES];
    return uiSwitch;
}

@end