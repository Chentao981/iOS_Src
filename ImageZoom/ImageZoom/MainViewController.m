//
//  MainViewController.m
//  ImageZoom
//
//  Created by Chentao on 15/4/30.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "MainViewController.h"
#import "ImageZoomView.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)loadView {
	ImageZoomView *zoomView = [[ImageZoomView alloc]init];
	zoomView.image = [UIImage imageNamed:@"test.jpg"];
	self.view = zoomView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


@end
