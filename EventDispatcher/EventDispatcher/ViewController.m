//
//  ViewController.m
//  EventDispatcher
//
//  Created by Chentao on 15/6/22.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

	[button addTarget:self action:@selector(onhandler) forControlEvents:UIControlEventTouchDown];


	SEL action1 = @selector(onhandler);
	SEL action2 = @selector(initWithCoder:);


	NSString *actionString = NSStringFromSelector(action2);  //*NSStringFromSelector (SEL aSelector);

	NSLog(@"%@", actionString);


	if (action1 == action2) {
		NSLog(@"=");
	}
	else {
		NSLog(@"!=");
	}


	NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
}

- (void)onhandler {
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
