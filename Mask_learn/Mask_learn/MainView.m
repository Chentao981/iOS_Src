//
//  MainView.m
//  Mask_learn
//
//  Created by Chentao on 15/2/9.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import "MainView.h"
#import "CircleView.h"

#import "CircleLoopView.h"


@interface MainView ()
@property(nonatomic,strong)CircleLoopView *circleView2;
@property(nonatomic,assign)CGFloat angle;

@end

@implementation MainView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CircleView *circleView1=[[CircleView alloc]initWithFrame:CGRectMake(30, 30, 100, 100)];
        UIImage *photo1=[UIImage imageNamed:@"photo1.jpeg"];
        circleView1.image=photo1;
        [self addSubview:circleView1];
        
        CircleView *circleView3=[[CircleView alloc]initWithFrame:CGRectMake(100, 100, 150, 150)];
        UIImage *photo2=[UIImage imageNamed:@"photo2.jpg"];
        circleView3.image=photo2;
        [self addSubview:circleView3];
        
        self.angle=0.0;
        
        self.circleView2=[[CircleLoopView alloc]initWithFrame:CGRectMake(100, 100, 150, 150)];
        [self addSubview:self.circleView2];
        [self rotationView:self.circleView2 andAngle:self.angle];
        
        
        [NSTimer scheduledTimerWithTimeInterval:0.004 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
        
    }
    return self;
}




-(void)rotationView:(UIView *)view andAngle:(CGFloat)angle{
    view.transform = CGAffineTransformMakeRotation(angle *M_PI / 180.0);
}


-(void)onTimer{
    self.angle+=1.0;
    [self rotationView:self.circleView2 andAngle:self.angle];
    if (self.angle==360) {
        self.angle=0;
    }
}


@end
