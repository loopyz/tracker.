//
//  TRSetTodaysPainView.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Ludo Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  TRSetTodaysPainView;

@interface TRSetTodaysPainView : UIView

@property (nonatomic, weak) id<TRSetTodaysPainView> delegate;


@end


@protocol TRSetTodaysPainView

@required
-(void)setLowPain;
-(void)setHighPain;
-(void)setMediumPain;

@end