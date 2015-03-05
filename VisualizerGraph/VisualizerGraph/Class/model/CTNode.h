//
//  CTNode.h
//  VisualizerGraph
//
//  Created by Chentao on 15/3/4.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import "CTItem.h"
@class CTEdge;
@interface CTNode : CTItem

@property (nonatomic,readonly)NSMutableDictionary *edges;

@property (nonatomic,strong)UIView *nodeView;
@property (nonatomic,assign)CGPoint toPoint;

-(NSMutableDictionary *)addEdge:(CTEdge *) edge;
-(NSMutableDictionary *)removeEdge:(CTEdge *) edge;

@end
