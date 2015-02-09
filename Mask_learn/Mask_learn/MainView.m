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



@end
