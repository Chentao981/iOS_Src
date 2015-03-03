//
//  NodeView.h
//  NodeView
//
//  Created by Chentao on 15/2/26.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NodeView;
@protocol NodeViewDelegate <NSObject>
@optional
-(void)positionChangeWithNodeView:(NodeView *)nodeView;
- (void)nodeViewTouchesBegan:(UIView *)view;
- (void)nodeViewTouchesMoved:(UIView *)view;
- (void)nodeViewTouchesEnded:(UIView *)view;
- (void)nodeViewTouchesCancelled:(UIView *)view;
- (void)nodeViewTap:(UIView *)view;
@end


@interface NodeView : UIView

@property(nonatomic,assign)CGFloat radius;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,assign)BOOL showLoading;


/**
 *  设置这个属性后View的坐标会伴随着动画效果改变
 */
@property(nonatomic,assign)CGPoint toPoint;

@property(nonatomic,weak)id<NodeViewDelegate> delegate;


@end
