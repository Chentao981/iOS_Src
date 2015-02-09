//
//  MainView.m
//  Mask_learn
//
//  Created by Chentao on 15/2/9.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import "MainView.h"
#import "CircleView.h"
@implementation MainView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CircleView *circleView1=[[CircleView alloc]initWithFrame:CGRectMake(30, 30, 100, 100)];
        UIImage *photo1=[UIImage imageNamed:@"photo1.jpeg"];
        circleView1.image=photo1;
        [self addSubview:circleView1];
        
        CircleView *circleView2=[[CircleView alloc]initWithFrame:CGRectMake(100, 100, 150, 150)];
        UIImage *photo2=[UIImage imageNamed:@"photo2.jpg"];
        circleView2.image=photo2;
        [self addSubview:circleView2];
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    // Create a gradient from white to red
    CGFloat colors [] = {
        1.0, 1.0, 1.0, 0.0,
        1.0, 0.0, 0.0, 1.0
    };
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    CGContextRef context=UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, 10.0);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(100, 100) radius:95 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    [path moveToPoint:CGPointMake(300, 0)];
    [path addLineToPoint:CGPointMake(300, 600)];
    
    CGContextAddPath(context, path.CGPath);
    CGContextReplacePathWithStrokedPath(context);
    CGContextClip(context);
    
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(0, 200);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient), gradient = NULL;
}

@end
