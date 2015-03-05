//
//  CTVisualizer.m
//  VisualizerGraph
//
//  Created by Chentao on 15/3/4.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import "CTVisualizer.h"

@implementation CTVisualizer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        _nodes =[[NSMutableDictionary alloc]init];
        _edges =[[NSMutableDictionary alloc]init];
        
    }
    return self;
}

-(CTNode *) addNodeWithId:(NSString *)nodeId itemData:(id) data{
    CTNode *node=[_nodes objectForKey:nodeId];
    if (!node) {
        node=[[CTNode alloc]init];
        node.itemId=nodeId;
        node.itemData=data;
        [_nodes setObject:node forKey:node.itemId];
    }
    return node;
}


-(CTEdge *) addEdgeWithId:(NSString *)edgeId sourceNode:(CTNode *)source targetNode:(CTNode *)target edgeData:(id) data {
    CTEdge *edge=[_edges objectForKey:edgeId];
    if (!edge) {
        edge=[[CTEdge alloc]initWithEdgeId:edgeId sourceNode:source targetNode:target];
        edge.itemData=data;
        [_edges setObject:edge forKey:edge.itemId];
    }
    return edge;
}

-(void) removeGraphNode:(CTNode *)node{
    if ([_nodes objectForKey:node.itemId]) {
        NSUInteger edgeCout=node.edges.count;
        NSArray *allkeys=[node.edges allKeys];
        for (NSInteger i=edgeCout-1; i>=0; i--) {
            NSString *edgeId=[allkeys objectAtIndex:i];
            CTEdge *edge=[node.edges objectForKey:edgeId];
            [self removeGraphEdge:edge];
        }
        [_nodes removeObjectForKey:node.itemId];
    }
}

-(void) removeGraphEdge:(CTEdge *)edge{
    if ([_edges objectForKey:edge.itemId]) {
        [edge.source removeEdge:edge];
        [edge.target removeEdge:edge];
        [_edges removeObjectForKey:edge.itemId];
    }
}


@end
