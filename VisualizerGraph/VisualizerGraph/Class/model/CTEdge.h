//
//  CTEdge.h
//  VisualizerGraph
//
//  Created by Chentao on 15/3/4.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import "CTItem.h"
#import "CTNode.h"
@interface CTEdge : CTItem

@property (nonatomic,readonly)CTNode *source;
@property (nonatomic,readonly)CTNode *target;

-(id)initWithEdgeId:(NSString *)edgeId sourceNode:(CTNode *)source targetNode:(CTNode *)target;

@end
