//
//  UIView+LayoutElement.h
//  CTUILayout
//
//  Created by Chentao on 15/2/3.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *为UIView扩展出一些布局属性;
 **/
@interface UIView (LayoutElement)

/**
 *指示是否要把此View加入到布局中,默认值为NO,不加入布局;
 **/
@property(nonatomic, assign) BOOL includeInLayout;

/**
 *距离父容器的左边距的值;
 **/
@property(nonatomic, strong) NSNumber *left;

/**
 *距离父容器的右边距的值;
 **/
@property(nonatomic, strong) NSNumber *right;

/**
 *距离父容器的上边距的值;
 **/
@property(nonatomic, strong) NSNumber *top;

/**
 *距离父容器的下边距的值;
 **/
@property(nonatomic, strong) NSNumber *bottom;

/**
 *此View的垂直方向中心线与父容器垂直方向中心线的偏移量;
 **/
@property(nonatomic, strong) NSNumber *verticalCenter;

/**
 *此View的水平方向中心线与父容器水平方向中心线的偏移量;
 **/
@property(nonatomic, strong) NSNumber *horizontalCenter;

/**
 *此View的宽度占父容器宽度的百分比;
 **/
@property(nonatomic, strong) NSNumber *percentWidth;

/**
 *此View的高度占父容器高度的百分比;
 **/
@property(nonatomic, strong) NSNumber *percentHeight;

/**
 *为了方便访问View的坐标及宽高,提供出下面4个属性
 **/
@property(nonatomic, assign) CGFloat x;
@property(nonatomic, assign) CGFloat y;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;

@end
