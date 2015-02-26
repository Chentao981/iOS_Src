//
//  CircleLoopView.m
//  Mask_learn
//
//  Created by Chentao on 15/2/26.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import "CircleLoopView.h"

@implementation CircleLoopView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}


-(void)drawRect:(CGRect)rect{

    CGFloat colors [] = {
        1.0, 1.0, 1.0, 0.0,
        1.0, 0.0, 0.0, 1.0
    };
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    CGFloat lineWidth=15.0;
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(0.5*self.bounds.size.width, 0.5*self.bounds.size.height) radius:0.5*self.bounds.size.width-0.5*lineWidth startAngle:1.5*M_PI endAngle:2.5*M_PI clockwise:YES];
    
    CGContextAddPath(context, path.CGPath);
    CGContextReplacePathWithStrokedPath(context);
    CGContextClip(context);
    
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(0, self.bounds.size.height);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient), gradient = NULL;

}

@end
