//
//  CustomeDatePicker.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomPickerActionDelegate <NSObject>
- (void)cancel:(id)sender;
- (void)done:(id)sender;
@end

@interface CustomDatePicker : UIDatePicker
@property (strong, nonatomic) UIView *navInputView;
@property (weak, nonatomic) id<CustomPickerActionDelegate> actionDelegate;
@end
