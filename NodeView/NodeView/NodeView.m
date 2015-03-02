//
//  NodeView.m
//  NodeView
//
//  Created by Chentao on 15/2/26.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import "NodeView.h"
#import "CircleView.h"
@interface NodeView()
@property (nonatomic,strong)CALayer *imageLayer;
@property (nonatomic,strong)CAShapeLayer *maskLayer;
@property (nonatomic,strong)CircleView *circleView;

@property (nonatomic,strong)NSTimer *loadingTimer;
@property (nonatomic,assign)CGFloat angle;
@end

@implementation NodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        
        self.imageLayer=[[CALayer alloc]init];
        [self.layer addSublayer:self.imageLayer];
        
        self.maskLayer=[[CAShapeLayer alloc]init];
        self.imageLayer.mask=self.maskLayer;
        
        self.circleView=[[CircleView alloc]init];
        [self addSubview:self.circleView];
        
        self.showLoading=NO;
    }
    return self;
}


-(void)setShowLoading:(BOOL)showLoading{
    if (showLoading) {
        [self rotationView:self.circleView andAngle:0.0];
        self.circleView.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        if (!self.loadingTimer) {
            self.loadingTimer=[NSTimer scheduledTimerWithTimeInterval:0.004 target:self selector:@selector(onLoadingTimer) userInfo:nil repeats:YES];
        }
    }else{
        if (self.loadingTimer) {
            [self.loadingTimer invalidate];
            self.loadingTimer=nil;
        }
    }
    self.circleView.hidden=!showLoading;
}

-(void)onLoadingTimer{
    self.angle+=1.0;
    [self rotationView:self.circleView andAngle:self.angle];
    if (self.angle==360.0) {
        self.angle=0.0;
    }
}

-(void)rotationView:(UIView *)view andAngle:(CGFloat)angle{
    view.transform = CGAffineTransformMakeRotation(angle *M_PI / 180.0);
}

-(void)setImage:(UIImage *)image{
    _image=image;
    self.imageLayer.contents=(id)_image.CGImage;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageLayer.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.maskLayer.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //绘制圆圈及阴影
    CGContextRef currentContext=UIGraphicsGetCurrentContext();
    UIColor *shadowColor=[UIColor blackColor];
    CGSize shadowOffset=CGSizeMake(0.0, 0.0);
    CGFloat shadowBulr=10.0f;
    
    CGFloat padding=1.0f;
    CGPoint centerPoint=CGPointMake(0.5*self.bounds.size.width, 0.5*self.bounds.size.height);
    CGFloat radius=0.5*self.bounds.size.width-shadowBulr-padding;
    
    UIBezierPath *ovalPath=[UIBezierPath bezierPath];
    [ovalPath addArcWithCenter:centerPoint radius:radius startAngle:0.0 endAngle:2*M_PI clockwise:YES];
    CGContextSaveGState(currentContext);
    CGContextSetShadowWithColor(currentContext, shadowOffset, shadowBulr, shadowColor.CGColor);
    [[UIColor whiteColor]setFill];
    [ovalPath fill];
    CGContextRestoreGState(currentContext);
    
    //绘制遮罩
    UIBezierPath *circleMaskPath=[UIBezierPath bezierPath];
    CGFloat circleMaskPadding=5.0;
    CGFloat circleMaskRadius=radius-circleMaskPadding;
    [circleMaskPath addArcWithCenter:centerPoint radius:circleMaskRadius startAngle:0.0 endAngle:2*M_PI clockwise:YES];
    self.maskLayer.path=circleMaskPath.CGPath;
    
    self.circleView.lineWidth=circleMaskPadding;
    self.circleView.radius=radius-0.5*circleMaskPadding;
    
}

@end
