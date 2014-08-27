//
//  SettingsViewController.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXForms.h"

@class SettingsObject;
@class FKFormModel;

//@interface SettingsViewController : FXFormViewController
@interface SettingsViewController : UITableViewController

@property (nonatomic, strong) FKFormModel *formModel;
@property (nonatomic, strong) SettingsObject *settingsObject;

@end

