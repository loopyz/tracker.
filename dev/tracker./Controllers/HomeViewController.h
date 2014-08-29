//
//  HomeViewController.h
//  tracker.
//
//  Created by Lucy Guo on 8/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THDatePickerViewController.h"
#import "SetTodaysPainView.h"
#import "SetTodaysFlowView.h"

@interface HomeViewController : UITableViewController<THDatePickerDelegate, SetTodaysPainView, SetTodaysFlowView>
@property (nonatomic, strong) THDatePickerViewController * datePicker;

@end
