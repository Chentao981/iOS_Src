//
//  NodeViewLayer.h
//  NodeView
//
//  Created by Chentao on 15/3/3.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@protocol NodeViewLayerDelegate <NSObject>

-(void)positionChangeWithLayer:(CALayer *)layer andNewPosition:(CGPoint)position;

@end


@interface NodeViewLayer : CALayer

@property(nonatomic,weak)id<NodeViewLayerDelegate> nodeViewLayerDelegate;
@property(nonatomic,assign)CGPoint toPoint;

@end
