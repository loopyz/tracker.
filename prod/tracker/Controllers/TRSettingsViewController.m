//
//  TRSettingsViewController.m
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Ludo Labs, Inc. All rights reserved.
//

#import "TRSettingsViewController.h"
#import "TRSettingsForm.h"
#import "FormKit.h"
#import "TRSettingsObject.h"

@interface TRSettingsViewController ()

@end

@implementation TRSettingsViewController

@synthesize formModel;
@synthesize settingsObject = _settingsObject;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        [self initNavBar];
        //set up form
        // self.formController.form = [[SettingsForm alloc] init];
        // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        // todo: figure out how to update the alarms to reflect what's in defaults
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [TRColors mainColor]};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // form model
    self.formModel = [FKFormModel formTableModelForTableView:self.tableView
                                        navigationController:self.navigationController];
    
    self.formModel.labelTextColor = [UIColor blackColor];
    self.formModel.valueTextColor = [UIColor lightGrayColor];
    self.formModel.topHeaderViewClass = [FKTitleHeaderView class];
    self.formModel.bottomHeaderViewClass = [FKTitleHeaderView class];
    
    TRSettingsObject *settingsObject = [TRSettingsObject settingsObject];
    settingsObject.pillNotifDate = [NSDate date];
    settingsObject.periodNotifOn = [NSNumber numberWithBool:YES];
    settingsObject.pillNotifOn = [NSNumber numberWithBool:YES];
    settingsObject.numDaysBeforePeriodNotif = [NSNumber numberWithInteger:2];
    
    self.settingsObject = settingsObject;
    
    [FKFormMapping mappingForClass:[TRSettingsObject class] block:^(FKFormMapping *formMapping) {
        [formMapping sectionWithTitle:@"Pill Notifications" footer:@"" identifier:@"info"];
        
        [formMapping mapAttribute:@"pillNotifOn" title:@"Turn on Pill Notifications" type:FKFormAttributeMappingTypeBoolean];
    
        
        [formMapping mappingForAttribute:@"pillNotifDate"
                                   title:@"Notification Time"
                                    type:FKFormAttributeMappingTypeTime
                        attributeMapping:^(FKFormAttributeMapping *mapping) {
                            
                            mapping.dateFormat = @"hh:mm a";
                            
                        }];

                
        [formMapping sectionWithTitle:@"Period Notifications" identifier:@"periodNotif"];
        
        [formMapping mapAttribute:@"periodNotifOn" title:@"Turn on Period Notifications" type:FKFormAttributeMappingTypeBoolean];
        [formMapping mapAttribute:@"numDaysBeforePeriodNotif" title:@"Days before Notification" type:FKFormAttributeMappingTypeInteger];

        
        [formMapping sectionWithTitle:@" " footer:@"hello" identifier:@"customCells"];
        
        [formMapping mapCustomCell:[UITableViewCell class]
                        identifier:@"savecell"
              willDisplayCellBlock:^(UITableViewCell *cell, id object, NSIndexPath *indexPath) {
                  cell.textLabel.text = @"Save Settings";
                  
              }     didSelectBlock:^(UITableViewCell *cell, id object, NSIndexPath *indexPath) {
                  NSLog(@"You pressed me");
                  [self.formModel save];
                  [self saveSettings];
              }];
        
        
        
        [formMapping mapCustomCell:[UITableViewCell class]
                        identifier:@"cleardata"
              willDisplayCellBlock:^(UITableViewCell *cell, id object, NSIndexPath *indexPath) {
                  cell.textLabel.text = @"Clear Data";
                  
              }     didSelectBlock:^(UITableViewCell *cell, id object, NSIndexPath *indexPath) {
                  // double check if you really want to clear data
                  [[[UIAlertView alloc] initWithTitle:@"Clear Data" message:@"Are you sure you want to delete all your data?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil] show];
              }];
        
        [self.formModel registerMapping:formMapping];
    }];
    
    [self.formModel setDidChangeValueWithBlock:^(id object, id value, NSString *keyPath) {
        NSLog(@"did change model value");
    }];
    
    [self updateSettings];
    
}

- (void)initNavBar
{
    
    self.navigationController.navigationBar.topItem.title = @"Settings";
    self.navigationItem.title = @"Settings";
}

//these are action methods for our forms
//the methods escalate through the responder chain until
//they reach the AppDelegate

- (void)saveSettings
{
    BOOL togglePillAlarm = [self.settingsObject.pillNotifOn boolValue];
    BOOL toggleStartPeriodAlarm = [self.settingsObject.periodNotifOn boolValue];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self.settingsObject.pillNotifDate];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger daysBefore = [self.settingsObject.numDaysBeforePeriodNotif integerValue];
    
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

    [self updateSettings];
}

- (void)clearData
{
   // clear all data here
    [TRUtil resetDefaults];
    [self updateSettings];
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
        //cancel clicked ...do nothing
    }else{
        // clearing data
        [self clearData];
        
    }
}

- (void)updateSettings
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *pillNotifOn = [NSNumber numberWithInteger:[defaults integerForKey:kTRPillAlarmToggleKey]];
    NSNumber *startPeriodNotifOn = [NSNumber numberWithInteger:[defaults integerForKey:kTRStartPeriodAlarmToggleKey]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self.settingsObject.pillNotifDate];
    [components setHour:[defaults integerForKey:kTRPillAlarmHourKey]];
    [components setMinute:[defaults integerForKey:kTRPillAlarmMinuteKey]];
    NSDate *pillNotifDate = [calendar dateFromComponents:components];
    NSNumber *daysBefore = [NSNumber numberWithInteger:[defaults integerForKey:kTRStartPeriodAlarmDaysBeforeKey]];
    
    self.settingsObject.pillNotifOn = pillNotifOn;
    self.settingsObject.periodNotifOn = startPeriodNotifOn;
    self.settingsObject.pillNotifDate = pillNotifDate;
    self.settingsObject.numDaysBeforePeriodNotif = daysBefore;
    [self.formModel loadFieldsWithObject:self.settingsObject];
}

@end
