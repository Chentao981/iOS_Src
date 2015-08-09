//
//  EventHandler.m
//  EventDispatcher
//
//  Created by Chentao on 15/7/16.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "EventHandler.h"

@implementation EventHandler

- (void)setTarget:(NSObject *)target {
  _target = target;

  [_target addEventListenerWithType:@"click1"
                          target:self
                          action:@selector(click1Handler:)];

  //  [_target addEventListenerWithType:@"click2"
  //                          andTarget:self
  //                          andAction:@selector(click2Handler:)];
}

- (void)click1Handler:(CEvent *)e {
  NSLog(@"%s  %@", __FUNCTION__, e.data);

//  [self.target removeEventListenerWithType:@"click1" target:self action:@selector(click1Handler:)];
}

- (void)click2Handler:(CEvent *)e {
  NSLog(@"%s  %@", __FUNCTION__, e.data);
}

@end
