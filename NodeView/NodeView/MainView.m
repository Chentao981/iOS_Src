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
@interface MainView()<NodeViewDelegate>
//@property (nonatomic,strong)NodeView *animationNodeView;

@property (nonatomic,strong)NSMutableArray *nodes;
@property (nonatomic,strong)NodeView *sourceNode;

@end


@implementation MainView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        //        NodeView *nodeView=[[NodeView alloc]initWithFrame:CGRectMake(100, 100, 150, 150)];
        //        nodeView.image=[UIImage imageNamed:@"davichi.jpg"];
        //        [self addSubview:nodeView];
        //        nodeView.showLoading=YES;
        //
        //
        //        NodeView *nodeView2=[[NodeView alloc]initWithFrame:CGRectMake(100, 300, 80, 80)];
        //        nodeView2.image=[UIImage imageNamed:@"lyn.jpg"];
        //        [self addSubview:nodeView2];
        //        nodeView2.showLoading=YES;
        //
        //
        //        NodeView *nodeView3=[[NodeView alloc]initWithFrame:CGRectMake(200, 400, 100, 100)];
        //        nodeView3.image=[UIImage imageNamed:@"secret.jpg"];
        //        [self addSubview:nodeView3];
        //        nodeView3.showLoading=YES;
        //
        //
        //
        //        self.animationNodeView=[[NodeView alloc]initWithFrame:CGRectMake(200, 200, 120, 120)];
        //        self.animationNodeView.image=[UIImage imageNamed:@"secret.jpg"];
        //        [self addSubview:self.animationNodeView];
        //        self.animationNodeView.showLoading=YES;
        
        NSArray *imageNames=[NSArray arrayWithObjects:@"davichi.jpg",@"lyn.jpg",@"secret.jpg",@"4minute.jpg",@"apink.jpg", nil];
        
        for (int i=0; i<10; i++) {
            CGFloat radius=arc4random()%150;
            
            if (radius<80) {
                radius=80;
            }
            
            NodeView *nodeView=[[NodeView alloc]initWithFrame:CGRectMake(arc4random()%(int)[UIScreen mainScreen].bounds.size.width, arc4random()%(int)[UIScreen mainScreen].bounds.size.height, radius, radius)];
            nodeView.delegate=self;
            nodeView.image=[UIImage imageNamed:[imageNames objectAtIndex: arc4random()%imageNames.count]];
            [self addSubview:nodeView];
            
            if (!self.nodes) {
                self.nodes=[[NSMutableArray alloc]init];
            }
            [self.nodes addObject:nodeView];
        }
        
        self.sourceNode=[[NodeView alloc]initWithFrame:CGRectMake(arc4random()%(int)[UIScreen mainScreen].bounds.size.width, arc4random()%(int)[UIScreen mainScreen].bounds.size.height, 100, 100)];
        self.sourceNode.delegate=self;
        self.sourceNode.image=[UIImage imageNamed:@"apink.jpg"];
        [self addSubview:self.sourceNode];
        
    }
    return self;
}


-(void)positionChangeWithNodeView:(NodeView *)nodeView{
    [self setNeedsDisplay];
}

- (void)nodeViewTouchesBegan:(UIView *)view{
    [self setNeedsDisplay];
}

- (void)nodeViewTouchesMoved:(UIView *)view{
    [self setNeedsDisplay];
}

- (void)nodeViewTouchesEnded:(UIView *)view{
    [self setNeedsDisplay];
}

- (void)nodeViewTouchesCancelled:(UIView *)view{
    [self setNeedsDisplay];
}

-(void)nodeViewTap:(UIView *)view{
    for (NodeView *nodeView in self.nodes) {
        CGPoint toPoint=CGPointMake(arc4random()%(int)[UIScreen mainScreen].bounds.size.width, arc4random()%(int)[UIScreen mainScreen].bounds.size.height);
        nodeView.toPoint=toPoint;
    }
    
    
    
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    UIBezierPath *bgPath=[UIBezierPath bezierPathWithRect:rect];
    [[UIColor whiteColor]setFill];
    [bgPath fill];
    
    CGPoint sourceNodePoint=self.sourceNode.center;
    for (NodeView *nodeView in self.nodes) {
        CGPoint targetPoint=nodeView.center;
        UIBezierPath *linePath=[UIBezierPath bezierPath];
        [linePath moveToPoint:sourceNodePoint];
        [linePath addLineToPoint:targetPoint];
        [[[UIColor grayColor]colorWithAlphaComponent:0.5] setStroke];
        [linePath stroke];
    }
}


@end
