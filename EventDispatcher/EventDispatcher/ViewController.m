//
//  ViewController.m
//  EventDispatcher
//
//  Created by Chentao on 15/6/22.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+CEventDispatcher.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	NSString *eventType = @"click";

	NSObject *obj = [[NSObject alloc]init];

	[obj addEventListenerWithType:eventType andTarget:self andAction:@selector(onClickHandler1:) andPriority:3];
	[obj addEventListenerWithType:eventType andTarget:self andAction:@selector(onClickHandler2:) andPriority:1];
	[obj addEventListenerWithType:eventType andTarget:self andAction:@selector(onClickHandler3:) andPriority:2];
	[obj addEventListenerWithType:eventType andTarget:self andAction:@selector(onClickHandler4:) andPriority:4];


//	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//
//	[button addTarget:self action:@selector(onhandler) forControlEvents:UIControlEventTouchDown];
//
//
//	SEL action1 = @selector(onhandler);
//	SEL action2 = @selector(initWithCoder:);
//
//
//	NSString *actionString = NSStringFromSelector(action2);  //*NSStringFromSelector (SEL aSelector);
//
//	NSLog(@"%@", actionString);
//
//
//	if (action1 == action2) {
//		NSLog(@"=");
//	}
//	else {
//		NSLog(@"!=");
//	}
//
//
//	NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
}

- (void)onClickHandler1:(CEvent *)event {
}

- (void)onClickHandler2:(CEvent *)event {
}

- (void)onClickHandler3:(CEvent *)event {
}

- (void)onClickHandler4:(CEvent *)event {
}

- (void)onhandler {
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
