//
//  SetTodaysFlowView.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  SetTodaysFlowView;

@interface SetTodaysFlowView : UIView

@property (nonatomic, weak) id<SetTodaysFlowView> delegate;

@end

@protocol SetTodaysFlowView

@required
-(void)setLightFlow;
-(void)setMediumFlow;
-(void)setHeavyFlow;

@end