//
//  MoveCircleView.h
//  BezierPath
//
//  Created by Chentao on 15/4/28.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoveCircleViewDelegate <NSObject>

- (void)touchesMoved:(UIView *)touch;

@end

@interface MoveCircleView : UIView

@property (nonatomic, strong) UIColor *bgColor;
@property (weak, nonatomic) id <MoveCircleViewDelegate> delegate;

@end
