//
//  CTNode.m
//  VisualizerGraph
//
//  Created by Chentao on 15/3/4.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import "CTNode.h"
#import "CTEdge.h"
@implementation CTNode

- (id)init
{
    self = [super init];
    if (self) {
        _edges=[[NSMutableDictionary alloc]init];
    }
    return self;
}

-(NSMutableDictionary *)addEdge:(CTEdge *) edge{
    if (![_edges objectForKey:edge.itemId]) {
        [_edges setObject:edge forKey:edge.itemId];
    }
    return _edges;
}


-(NSMutableDictionary *)removeEdge:(CTEdge *) edge{
    [_edges removeObjectForKey:edge.itemId];
    return _edges;
}
- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}
@end
