//
//  MainViewController.m
//  VisualizerGraph
//
//  Created by Chentao on 15/3/4.
//  Copyright (c) 2015年 CT. All rights reserved.
//

#import "MainViewController.h"
#import "CTVisualizer.h"
@interface MainViewController ()

@end

@implementation MainViewController


-(void)loadView{
    CTVisualizer *visualizer=[[CTVisualizer alloc]init];
    self.view=visualizer;
}

-(CTVisualizer *)visualizer{
    return (CTVisualizer *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CTNode *node0=[[self visualizer] addNodeWithId:@"node0" itemData:@"node0"];
    CTNode *node1=[[self visualizer] addNodeWithId:@"node1" itemData:@"node1"];
    
    CTEdge *edge0=[[self visualizer] addEdgeWithId:@"edge0" sourceNode:node0 targetNode:node1 edgeData:@"edge0"];
    
    
    
    //[[self visualizer ]removeGraphEdge:edge0];
    [[self visualizer]removeGraphNode:node0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
