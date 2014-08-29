//
//  TRSetTodaysFlowView.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Ludo Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  TRSetTodaysFlowView;

@interface TRSetTodaysFlowView : UIView

@property (nonatomic, weak) id<TRSetTodaysFlowView> delegate;

@end

@protocol TRSetTodaysFlowView

@required
-(void)setLightFlow;
-(void)setMediumFlow;
-(void)setHeavyFlow;

@end