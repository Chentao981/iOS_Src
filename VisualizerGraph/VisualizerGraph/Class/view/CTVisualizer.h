//
//  CTVisualizer.h
//  VisualizerGraph
//
//  Created by Chentao on 15/3/4.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTEdge.h"
#import "CTNode.h"


@class CTVisualizer;
@protocol CTVisualizerLayout <NSObject>

@required
-(void)layoutComputeStart:(CTVisualizer *)visualizer;

@optional
-(void)layoutComplete:(CTVisualizer *)visualizer;
@end


@protocol CTVisualizerDelegate <NSObject>


@end


@interface CTVisualizer : UIView

@property (nonatomic,readonly)NSMutableDictionary *nodes;
@property (nonatomic,readonly)NSMutableDictionary *edges;

@property (nonatomic,weak)id<CTVisualizerLayout> layout;
@property (nonatomic,weak)id<CTVisualizerDelegate> delegate;

-(CTNode *) addNodeWithId:(NSString *)nodeId itemData:(id) data;
-(CTEdge *) addEdgeWithId:(NSString *)edgeId sourceNode:(CTNode *)source targetNode:(CTNode *)target edgeData:(id) data;

-(void) removeGraphNode:(CTNode *)node;
-(void) removeGraphEdge:(CTEdge *)edge;

@end
