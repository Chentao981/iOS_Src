//
//  CTUIContainer.m
//  CTUILayout
//
//  Created by Chentao on 15/2/3.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//
#import "CTUIContainer.h"

@implementation CTUIContainer

- (void)layoutSubviews {
  [super layoutSubviews];
    if (self.containerLayout && [self.containerLayout respondsToSelector:@selector(containerLayoutSubviews:)]) {
        [self.containerLayout containerLayoutSubviews:self];
    }
}

@end
