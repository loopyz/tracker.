//
//  SetTodaysPainView.h
//  tracker.
//
//  Created by Lucy Guo on 8/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  SetTodaysPainView;

@interface SetTodaysPainView : UIView

@property (nonatomic, weak) id<SetTodaysPainView> delegate;


@end


@protocol SetTodaysPainView

@required
-(void)setLowPain;
-(void)setHighPain;
-(void)setMediumPain;

@end