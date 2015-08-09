//
//  ViewController.m
//  EventDispatcher
//
//  Created by Chentao on 15/6/22.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+CEventDispatcher.h"

#import "EventHandler.h"
#import "EventHandler2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *eventType1 = @"click1";
    //  NSString *eventType2 = @"click2";
    
    NSObject *obj = [[NSObject alloc] init];
    
    
    EventHandler *eh1 = [[EventHandler alloc] init];
    eh1.target = obj;
    
    EventHandler2 *eh2 = [[EventHandler2 alloc] init];
    eh2.target = obj;
    
    [obj addEventListenerWithType:eventType1
                           target:self
                           action:@selector(onClickHandler1:)];
    
    CEvent *e = [[CEvent alloc] initWithType:eventType1 andData:nil];
    e.data = @"text";
    [obj dispatchEvent:e];
    
    eh1=nil;
    
    CEvent *e1 = [[CEvent alloc] initWithType:eventType1 andData:nil];
    e1.data = @"text";
    [obj dispatchEvent:e1];
    
    
    
    //
    //  [obj dispatchEvent:e];
    
    //  NSString *eventType1 = @"click1";
    //  NSString *eventType2 = @"click2";
    //
    //  NSObject *obj = [[NSObject alloc] init];
    //
    //  [obj addEventListenerWithType:eventType1
    //                      andTarget:self
    //                      andAction:@selector(onClickHandler1:)];
    //
    //  [obj addEventListenerWithType:eventType1
    //                      andTarget:self
    //                      andAction:@selector(onClickHandler2:)];
    //
    //  [obj addEventListenerWithType:eventType1
    //                      andTarget:self
    //                      andAction:@selector(onClickHandler3:)];
    //
    //  [obj addEventListenerWithType:eventType1
    //                      andTarget:self
    //                      andAction:@selector(onClickHandler4:)];
    //
    //  CEvent *e = [[CEvent alloc] initWithType:eventType1 andData:nil];
    //  e.data = @"text";
    //  [obj dispatchEvent:e];
    //
    //  [obj addEventListenerWithType:eventType2
    //                      andTarget:self
    //                      andAction:@selector(onClickHandler1:)];
    //
    //  [obj addEventListenerWithType:eventType2
    //                      andTarget:self
    //                      andAction:@selector(onClickHandler2:)];
    //
    //  [obj addEventListenerWithType:eventType2
    //                      andTarget:self
    //                      andAction:@selector(onClickHandler3:)];
    //
    //  [obj addEventListenerWithType:eventType2
    //                      andTarget:self
    //                      andAction:@selector(onClickHandler4:)];
    //
    //  CEvent *e2 = [[CEvent alloc] initWithType:eventType2 andData:nil];
    //  e2.data = @"text2";
    //  [obj dispatchEvent:e2];
}
//
- (void)onClickHandler1:(CEvent *)event {
    NSLog(@"%s  %@", __FUNCTION__, event.data);
    //  [event.dispatcherOwner
    //      removeEventListenerWithType:@"click1"
    //                        andTarget:self
    //                           action:@selector(onClickHandler1:)];
}
//
//- (void)onClickHandler2:(CEvent *)event {
//  NSLog(@"%s  %@", __FUNCTION__, event.data);
//}
//
//- (void)onClickHandler3:(CEvent *)event {
//  NSLog(@"%s  %@", __FUNCTION__, event.data);
//}
//
//- (void)onClickHandler4:(CEvent *)event {
//  NSLog(@"%s  %@", __FUNCTION__, event.data);
//}

- (void)onhandler {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
