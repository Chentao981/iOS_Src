//
//  ViewController.m
//  BezierPath
//
//  Created by Chentao on 15/4/28.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "ViewController.h"
#import "Canvas.h"
@interface ViewController ()

@end

@implementation ViewController


- (void)loadView {
	Canvas *canvas = [[Canvas alloc]init];
	self.view = canvas;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
