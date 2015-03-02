//
//  MainView.m
//  NodeView
//
//  Created by Chentao on 15/2/26.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import "MainView.h"
#import "NodeView.h"
#import "CircleView.h"
@interface MainView()
@end


@implementation MainView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        NodeView *nodeView=[[NodeView alloc]initWithFrame:CGRectMake(100, 100, 150, 150)];
        nodeView.image=[UIImage imageNamed:@"davichi.jpg"];
        [self addSubview:nodeView];
        nodeView.showLoading=YES;
        
        
        NodeView *nodeView2=[[NodeView alloc]initWithFrame:CGRectMake(100, 300, 80, 80)];
        nodeView2.image=[UIImage imageNamed:@"lyn.jpg"];
        [self addSubview:nodeView2];
        //nodeView2.showLoading=YES;
        
        
        NodeView *nodeView3=[[NodeView alloc]initWithFrame:CGRectMake(200, 400, 100, 100)];
        nodeView3.image=[UIImage imageNamed:@"secret.jpg"];
        [self addSubview:nodeView3];
        nodeView3.showLoading=YES;
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

}

@end
