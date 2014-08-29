//
//  TRSettingsViewController.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Ludo Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXForms.h"

@class TRSettingsObject;
@class FKFormModel;

//@interface SettingsViewController : FXFormViewController
@interface TRSettingsViewController : UITableViewController<UIAlertViewDelegate>

@property (nonatomic, strong) FKFormModel *formModel;
@property (nonatomic, strong) TRSettingsObject *settingsObject;

@end

