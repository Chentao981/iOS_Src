//
//  LoadingView.h
//  Loading2
//
//  Created by Chentao on 15/5/8.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

/**
 *线的宽度
 **/
@property (nonatomic, assign) CGFloat lineWidth;

/**
 *动画周期
 **/
@property (nonatomic, assign) CGFloat duration;

/**
 *显示隐藏Loading
 **/
- (void)showLoading:(BOOL)show;

@end
