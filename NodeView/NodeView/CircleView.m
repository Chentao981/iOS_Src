//
//  CircleView.m
//  NodeView
//
//  Created by Chentao on 15/3/2.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)setLineWidth:(CGFloat)lineWidth{
    if (_lineWidth!=lineWidth) {
        _lineWidth=lineWidth;
        [self setNeedsDisplay];
    }
}

-(void)setRadius:(CGFloat)radius{
    if (_radius!=radius) {
        _radius=radius;
        [self setNeedsDisplay];
    }
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGFloat gradientColor[]={
        1.0,0.0,0.0,0,
        1.0,0.0,0.0,1.0
    };
    
    CGColorSpaceRef baseSpace=CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient=CGGradientCreateWithColorComponents(baseSpace, gradientColor, NULL, 2);
    CGColorSpaceRelease(baseSpace);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGPoint centerPoint=CGPointMake(0.5*self.bounds.size.width, 0.5*self.bounds.size.height);
    UIBezierPath *circlePath=[UIBezierPath bezierPath];
    [circlePath addArcWithCenter:centerPoint radius:self.radius startAngle:1.5*M_PI endAngle:2.5*M_PI clockwise:YES];
    
    CGContextAddPath(context, circlePath.CGPath);
    CGContextReplacePathWithStrokedPath(context);
    CGContextClip(context);
    
    CGPoint startPoint=CGPointMake(0.0, 0.5*self.bounds.size.height-self.radius);
    CGPoint endPoint=CGPointMake(0.0, self.bounds.size.height);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint,0);
    CGGradientRelease(gradient);
}

@end
