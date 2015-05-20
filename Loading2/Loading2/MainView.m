//
//  MainView.m
//  Loading2
//
//  Created by Chentao on 15/5/8.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "MainView.h"
#import "LoadingView.h"


@interface MainView ()

@property (nonatomic, strong) LoadingView *loadingView1;
@property (nonatomic, strong) LoadingView *loadingView2;
@property (nonatomic, strong) LoadingView *loadingView3;
@property (nonatomic, strong) LoadingView *loadingView4;

@end

@implementation MainView


- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		CGFloat centerX = 0.5 * [UIScreen mainScreen].bounds.size.width;


		self.loadingView1 = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
		self.loadingView1.center = CGPointMake(centerX, 50);
		self.loadingView1.lineWidth = 1.0;
		self.loadingView1.duration = 2.5;

		[self addSubview:self.loadingView1];
		[self.loadingView1 showLoading:YES];

		self.loadingView2 = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
		self.loadingView2.center = CGPointMake(centerX, 110);
		self.loadingView2.lineWidth = 2.0;
		self.loadingView2.duration = 2.5;

		[self addSubview:self.loadingView2];
		[self.loadingView2 showLoading:YES];


		self.loadingView3 = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
		self.loadingView3.center = CGPointMake(centerX, 200);
		self.loadingView3.lineWidth = 3.0;
		self.loadingView3.duration = 2.5;

		[self addSubview:self.loadingView3];
		[self.loadingView3 showLoading:YES];


		self.loadingView4 = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
		self.loadingView4.center = CGPointMake(centerX, 310);
		self.loadingView4.lineWidth = 4.0;
		self.loadingView4.duration = 2.5;

		[self addSubview:self.loadingView4];
		[self.loadingView4 showLoading:YES];


		UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[startButton addTarget:self action:@selector(startButtonOnTouchHandler) forControlEvents:UIControlEventTouchUpInside];
		startButton.backgroundColor = [UIColor grayColor];
		startButton.frame = CGRectMake(20, 500, 100, 50);
		[startButton setTitle:@"开 始" forState:UIControlStateNormal];
		[self addSubview:startButton];

		UIButton *stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[stopButton addTarget:self action:@selector(stopButtonOnTouchHandler) forControlEvents:UIControlEventTouchUpInside];
		stopButton.backgroundColor = [UIColor grayColor];
		stopButton.frame = CGRectMake(220, 500, 100, 50);
		[stopButton setTitle:@"停 止" forState:UIControlStateNormal];
		[self addSubview:stopButton];
	}
	return self;
}

- (void)stopButtonOnTouchHandler {
	[self.loadingView1 showLoading:NO];
	[self.loadingView2 showLoading:NO];
	[self.loadingView3 showLoading:NO];
	[self.loadingView4 showLoading:NO];
}

- (void)startButtonOnTouchHandler {
	[self.loadingView1 showLoading:YES];
	[self.loadingView2 showLoading:YES];
	[self.loadingView3 showLoading:YES];
	[self.loadingView4 showLoading:YES];
}

@end
