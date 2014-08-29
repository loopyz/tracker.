//
//  TRHomeViewController.h
//  tracker.
//
//  Created by Lucy Guo on 8/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THDatePickerViewController.h"
#import "TRSetTodaysPainView.h"
#import "TRSetTodaysFlowView.h"

@interface TRHomeViewController : UITableViewController<THDatePickerDelegate, TRSetTodaysPainView, TRSetTodaysFlowView>
@property (nonatomic, strong) THDatePickerViewController * datePicker;

@end
