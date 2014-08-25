//
//  HomeViewController.h
//  tracker.
//
//  Created by Lucy Guo on 8/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THDatePickerViewController.h"

@interface HomeViewController : UITableViewController<THDatePickerDelegate>
@property (nonatomic, strong) THDatePickerViewController * datePicker;

@end
