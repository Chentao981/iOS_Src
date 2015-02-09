//
//  CircleView.m
//  Mask_learn
//
//  Created by Chentao on 15/2/9.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import "CircleView.h"


@interface CircleView ()

@property(nonatomic,strong)CALayer *imageLayer;
@property(nonatomic,strong)CAShapeLayer *imageMaskLayer;

@end


@implementation CircleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        
        self.imageLayer=[[CALayer alloc]init];
        self.imageLayer.contentsGravity=@"resizeAspectFill";
        [self.layer addSublayer:self.imageLayer];
        
        self.imageMaskLayer=[[CAShapeLayer alloc]init];
        self.imageMaskLayer.fillColor=[UIColor whiteColor].CGColor;
        self.imageLayer.mask=self.imageMaskLayer;
    }
    return self;
}

-(void)setImage:(UIImage *)image{
    _image=image;
    self.imageLayer.contents=(id)_image.CGImage;
    [self setNeedsLayout];
    [self setNeedsDisplay];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageMaskLayer.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.imageLayer.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    /////////////////////////绘制阴影//////////////////
    CGContextRef context=UIGraphicsGetCurrentContext();
    UIColor* shadow = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    CGSize shadowOffset = CGSizeMake(0.0, 0.0);
    CGFloat shadowBlurRadius = 10.0f;
    
    CGFloat padding=1.0f;
    CGPoint centerPoint=CGPointMake(0.5*self.bounds.size.width, 0.5*self.bounds.size.height);
    CGFloat radius=0.5*self.bounds.size.width-padding-0.9*shadowBlurRadius;
    
    UIBezierPath *ovalPath=[UIBezierPath bezierPath];
    [ovalPath addArcWithCenter:centerPoint radius:radius startAngle:0 endAngle:2*M_PI clockwise:NO];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, [shadow CGColor]);
    [[UIColor whiteColor] setFill];
    [ovalPath fill];
    CGContextRestoreGState(context);
    ///////////////////////////////////////////////////
    
    /////////////////////////绘制图片遮罩////////////////
    UIBezierPath *imageMaskPath=[UIBezierPath bezierPath];
    CGFloat imageMaskRadius=radius-4.0f;
    [imageMaskPath addArcWithCenter:centerPoint radius:imageMaskRadius startAngle:0.0f endAngle:2*M_PI clockwise:NO];
    self.imageMaskLayer.path=imageMaskPath.CGPath;
}

@end
