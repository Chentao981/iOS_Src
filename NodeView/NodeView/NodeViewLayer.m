//
//  NodeViewLayer.m
//  NodeView
//
//  Created by Chentao on 15/3/3.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import "NodeViewLayer.h"

@implementation NodeViewLayer
{
    BOOL setToPoint;
}
@dynamic toPoint;


+(BOOL)needsDisplayForKey:(NSString *)key{
    if ([@"toPoint" isEqualToString:key]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

-(void)display{
    [super display];
    if (setToPoint) {
        self.position=[self.presentationLayer toPoint];
        if (self.nodeViewLayerDelegate && [self.nodeViewLayerDelegate respondsToSelector:@selector(positionChangeWithLayer:andNewPosition:)]) {
            [self.nodeViewLayerDelegate positionChangeWithLayer:self andNewPosition:self.position];
        }
    }
}

-(id<CAAction>)actionForKey:(NSString *)event{
    if ([@"toPoint" isEqualToString:event]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        CGPoint fromValue=self.position;
        animation.fromValue =[NSValue valueWithCGPoint:fromValue];
        setToPoint=YES;
        return animation;
    }
    return [super actionForKey:event];
}

-(void)setPosition:(CGPoint)position{
    [super setPosition:position];
    if (self.nodeViewLayerDelegate && [self.nodeViewLayerDelegate respondsToSelector:@selector(positionChangeWithLayer:andNewPosition:)]) {
        [self.nodeViewLayerDelegate positionChangeWithLayer:self andNewPosition:self.position];
    }
}


@end
