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

  NSObject *obj = [[NSObject alloc] init];

  //添加事件监听
  [obj addEventListenerWithType:eventType
                      andTarget:self
                      andAction:@selector(onClickHandler1:)
                    andPriority:1];
  [obj addEventListenerWithType:eventType
                      andTarget:self
                      andAction:@selector(onClickHandler2:)
                    andPriority:1];
  [obj addEventListenerWithType:eventType
                      andTarget:self
                      andAction:@selector(onClickHandler3:)
                    andPriority:2];
  [obj addEventListenerWithType:eventType
                      andTarget:self
                      andAction:@selector(onClickHandler4:)
                    andPriority:2];

  CEvent *event1 = [[CEvent alloc] init];
  event1.type = eventType;
  event1.data = [NSNumber numberWithFloat:1010.01];
  //派发事件
  [obj dispatchEvent:event1];

  //移除一个监听器
  [obj removeEventListenerWithType:eventType
                         andTarget:self
                            action:@selector(onClickHandler4:)];
  [obj removeEventListenerWithType:eventType
                         andTarget:self
                            action:@selector(onClickHandler3:)];
  [obj removeEventListenerWithType:eventType
                         andTarget:self
                            action:@selector(onClickHandler1:)];

  [obj removeEventListenerWithType:eventType
                         andTarget:self
                            action:@selector(onClickHandler2:)];

  CEvent *event2 = [[CEvent alloc] init];
  event2.type = eventType;
  event2.data = [NSNumber numberWithFloat:2020.02];
  //派发事件
  [obj dispatchEvent:event2];

  //移除所有事件监听
  [obj removeAllEventListener];

  CEvent *event3 = [[CEvent alloc] init];
  event3.type = eventType;
  event3.data = [NSNumber numberWithFloat:3030.03];
  //派发事件
  [obj dispatchEvent:event3];

  //添加事件监听
  [obj addEventListenerWithType:eventType
                      andTarget:self
                      andAction:@selector(onClickHandler3:)
                    andPriority:2];
  [obj addEventListenerWithType:eventType
                      andTarget:self
                      andAction:@selector(onClickHandler4:)
                    andPriority:2];

  [obj removeEventListenerWithType:eventType
                         andTarget:self
                            action:@selector(onClickHandler2:)];

  CEvent *event4 = [[CEvent alloc] init];
  event4.type = eventType;
  event4.data = [NSNumber numberWithFloat:4040.04];
  //派发事件
  [obj dispatchEvent:event4];
}

- (void)onClickHandler1:(CEvent *)event {
  NSLog(@"%s  %@", __FUNCTION__, event.data);
}

- (void)onClickHandler2:(CEvent *)event {
  NSLog(@"%s  %@", __FUNCTION__, event.data);
}

- (void)onClickHandler3:(CEvent *)event {
  NSLog(@"%s  %@", __FUNCTION__, event.data);
}

- (void)onClickHandler4:(CEvent *)event {
  NSLog(@"%s  %@", __FUNCTION__, event.data);
}

- (void)onhandler {
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
