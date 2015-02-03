//
//  CTUIBox.h
//  CTUILayout
//
//  Created by Chentao on 15/2/3.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LayoutElement.h"

typedef NS_ENUM(NSInteger, BoxAlignType) {
  BoxAlignTypeTop = 0,
  BoxAlignTypeBottom,
  BoxAlignTypeLeft,
  BoxAlignTypeRight,
  BoxAlignTypeCenter,
};

@class CTUIBox;
@protocol BoxDelegate <NSObject>

/**
 *Box的宽高发生变化
 **/
- (void)boxReSize:(CTUIBox *)box;
@end

/**
 *抽象父类，请使用它的子类。
 **/
@interface CTUIBox : UIView

/**
 *用来指示Box是否自动测量自己的宽高,在自动测量宽高时,gap,paddingTop,paddingBottom,paddingLeft,paddingRight,和子组件的宽高都会影响到最后的测量结果;
 *此值的默认为NO,不自动测量;
 **/
@property(nonatomic) BOOL measure;

/**
 *子组件之间的间隙;
 **/
@property(nonatomic) CGFloat gap;

/**
 *边距
 **/
@property(nonatomic) CGFloat paddingTop;
@property(nonatomic) CGFloat paddingBottom;
@property(nonatomic) CGFloat paddingLeft;
@property(nonatomic) CGFloat paddingRight;

/**
 *垂直对齐方式
 **/
@property(nonatomic) BoxAlignType verticalAlign;

/**
 *水平对齐方式
 **/
@property(nonatomic) BoxAlignType horizontalAlign;


@property(nonatomic, weak) id<BoxDelegate> boxDelegate;

- (CGSize)measureBoxSize;

@end
