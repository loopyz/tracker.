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
#import "FormKit.h"
#import "SettingsObject.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [Colors mainColor]};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.formModel = [FKFormModel formTableModelForTableView:self.tableView
                                        navigationController:self.navigationController];
    
    self.formModel.labelTextColor = [UIColor blackColor];
    self.formModel.valueTextColor = [UIColor lightGrayColor];
    self.formModel.topHeaderViewClass = [FKTitleHeaderView class];
    self.formModel.bottomHeaderViewClass = [FKTitleHeaderView class];
    
    SettingsObject *settingsObject = [SettingsObject settingsObject];
    settingsObject.pillNotifDate = [NSDate date];
    settingsObject.periodNotifOn = [NSNumber numberWithBool:YES];
    settingsObject.pillNotifOn = [NSNumber numberWithBool:YES];
    settingsObject.numDaysBeforePeriodNotif = [NSNumber numberWithInteger:2];
    
    self.settingsObject = settingsObject;
    
    [FKFormMapping mappingForClass:[SettingsObject class] block:^(FKFormMapping *formMapping) {
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

        
        [formMapping sectionWithTitle:@"More Options" identifier:@"customCells"];
        
//        [formMapping mapCustomCell:[FKDisclosureIndicatorAccessoryField class]
//                        identifier:@"custom"
//                         rowHeight:70
//                         blockData:@(1)
//              willDisplayCellBlock:^(UITableViewCell *cell, id object, NSIndexPath *indexPath, id blockData) {
//                  cell.textLabel.text = [NSString stringWithFormat:@"I am a custom cell ! With blockData %@", [blockData description]];
//                  cell.textLabel.numberOfLines = 0;
//                  
//              }     didSelectBlock:^(UITableViewCell *cell, id object, NSIndexPath *indexPath, id blockData) {
//                  NSLog(@"You pressed me");
//                  
//              }];
        
        [formMapping mapCustomCell:[UITableViewCell class]
                        identifier:@"savecell"
              willDisplayCellBlock:^(UITableViewCell *cell, id object, NSIndexPath *indexPath) {
                  cell.textLabel.text = @"Save Settings";
                  
              }     didSelectBlock:^(UITableViewCell *cell, id object, NSIndexPath *indexPath) {
                  NSLog(@"You pressed me");
                  [self.formModel save];
                  
              }];
        
        
        
        [formMapping mapCustomCell:[UITableViewCell class]
                        identifier:@"cleardata"
              willDisplayCellBlock:^(UITableViewCell *cell, id object, NSIndexPath *indexPath) {
                  cell.textLabel.text = @"Clear Data";
                  
              }     didSelectBlock:^(UITableViewCell *cell, id object, NSIndexPath *indexPath) {
                  NSLog(@"You pressed me again");
                  // TODO: DO CLEAR DATA HERE
                  
              }];
        
        
//        [formMapping sectionWithTitle:@"Buttons" identifier:@"saveButton"];
//        
//        [formMapping buttonSave:@"Save" handler:^{
//            NSLog(@"save pressed");
//            NSLog(@"%@", self.settingsObject);
//            [self.formModel save];
//        }];
//        
//        [formMapping validationForAttribute:@"custom" validBlock:^BOOL(id value, id object) {
//            return NO;
//        } errorMessageBlock:^NSString *(id value, id object) {
//            return @"Error";
//        }];
//        
//        [formMapping validationForAttribute:@"title" validBlock:^BOOL(NSString *value, id object) {
//            return value.length < 10;
//            
//        } errorMessageBlock:^NSString *(id value, id object) {
//            return @"Text is too long.";
//        }];
//        
//        [formMapping validationForAttribute:@"releaseDate" validBlock:^BOOL(id value, id object) {
//            return NO;
//        }];
        
        [self.formModel registerMapping:formMapping];
    }];
    
    [self.formModel setDidChangeValueWithBlock:^(id object, id value, NSString *keyPath) {
        NSLog(@"did change model value");
    }];
    
    [self.formModel loadFieldsWithObject:settingsObject];
    
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
