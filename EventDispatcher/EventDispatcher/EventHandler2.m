//
//  EventHandler2.m
//  EventDispatcher
//
//  Created by Chentao on 15/7/16.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "EventHandler2.h"

@implementation EventHandler2

- (void)setTarget:(NSObject *)target {
  _target = target;

  [_target addEventListenerWithType:@"click1"
                          target:self
                          action:@selector(click1Handler:)
                          priority:1];

  //  [_target addEventListenerWithType:@"click2"
  //                          andTarget:self
  //                          andAction:@selector(click2Handler:)
  //                        andPriority:1];
}

- (void)click1Handler:(CEvent *)e {
  NSLog(@"%s  %@", __FUNCTION__, e.data);

//  [self.target removeEventListenerWithType:@"click1" target:self action:@selector(click1Handler:)];
}

- (void)click2Handler:(CEvent *)e {
  NSLog(@"%s  %@", __FUNCTION__, e.data);
}

@end
