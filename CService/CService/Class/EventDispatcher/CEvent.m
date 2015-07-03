//
//  CEvent.m
//  EventDispatcher
//
//  Created by Chentao on 15/6/22.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "CEvent.h"

@implementation CEvent

- (instancetype)initWithType:(NSString *)type andData:(id)data {
	self = [super init];
	if (self) {
		self.type = type;
		self.data = data;
	}
	return self;
}

- (CEvent *)clone {
	return [[CEvent alloc]initWithType:self.type andData:self.data];
}

@end
