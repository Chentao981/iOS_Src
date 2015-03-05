//
//  CTEdge.m
//  VisualizerGraph
//
//  Created by Chentao on 15/3/4.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import "CTEdge.h"

@implementation CTEdge


-(id)initWithEdgeId:(NSString *)edgeId sourceNode:(CTNode *)source targetNode:(CTNode *)target{
    self = [super init];
    if (self) {
        self.itemId=edgeId;
        _source=source;
        [_source addEdge:self];
        
        _target=target;
        if (source != target) {
            [_target addEdge:self];
        }
    }
    return self;
}


- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

@end
