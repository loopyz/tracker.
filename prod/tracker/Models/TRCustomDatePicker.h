//
//  TRCustomeDatePicker.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Ludo Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TRCustomPickerActionDelegate <NSObject>
- (void)cancel:(id)sender;
- (void)done:(id)sender;
@end

@interface TRCustomDatePicker : UIDatePicker
@property (strong, nonatomic) UIView *navInputView;
@property (weak, nonatomic) id<TRCustomPickerActionDelegate> actionDelegate;
@end
