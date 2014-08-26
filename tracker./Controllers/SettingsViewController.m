//
//  SettingsViewController.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsForm.h"
#import "Colors.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        [self initNavBar];
        //set up form
        self.formController.form = [[SettingsForm alloc] init];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        // todo: figure out how to update the alarms to reflect what's in defaults
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [Colors mainColor]};
}

- (void)initNavBar
{
    
    self.navigationController.navigationBar.topItem.title = @"Settings";
    self.navigationItem.title = @"Settings";
}

//these are action methods for our forms
//the methods escalate through the responder chain until
//they reach the AppDelegate

- (void)saveSettings:(UITableViewCell<FXFormFieldCell> *)cell
{
    //we can lookup the form from the cell if we want, like this:
    SettingsForm *form = cell.field.form;
    
    // todo: update with real form values
    BOOL togglePillAlarm = (form.pillNotif == PillNotificationsOn);
    BOOL toggleStartPeriodAlarm = (form.periodNotif == PeriodNotificationsOn);
    NSInteger hour = 9;
    NSInteger minute = 0;
    NSInteger daysBefore = form.daysBefore;
    
    if (togglePillAlarm) {
        [TRUtil setPillAlarm:hour minute:minute];
    } else {
        [TRUtil removePillAlarm];
    }
    
    if (toggleStartPeriodAlarm) {
        [TRUtil setStartPeriodAlarm:daysBefore hour:kTRDefaultAlertHour];
    } else {
        [TRUtil removeStartPeriodAlarm];
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Saved Settings!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

- (void)clearData
{
   // clear all data here
    [TRUtil resetDefaults];
}



@end
