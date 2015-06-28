//
//  NSObject+EventDispatcher.m
//  EventDispatcher
//
//  Created by Chentao on 15/6/22.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "NSObject+CEventDispatcher.h"
#import <objc/runtime.h>

static const char EVENT_LISTENERS;


@interface CEventListener : NSObject
@property (nonatomic, strong) id target;
@property (nonatomic, strong) NSMutableArray *actions;
@end

@implementation CEventListener
@end


@implementation NSObject (CEventDispatcher)

- (void)addEventListenerWithType:(NSString *)type andTarget:(id)target andAction:(SEL)action andPriority:(NSUInteger)priority {
	NSMutableDictionary *typeEventListeners = [[self eventListeners]objectForKey:type];
	if (!typeEventListeners) {
		typeEventListeners = [[NSMutableDictionary alloc]init];
		[[self eventListeners]setObject:typeEventListeners forKey:type];
	}

	NSString *priorityKey = [NSString stringWithFormat:@"%@", @(priority)];
	NSMutableArray *listeners = [typeEventListeners objectForKey:priorityKey];
	if (!listeners) {
		listeners = [[NSMutableArray alloc]init];
		[typeEventListeners setObject:listeners forKey:priorityKey];
	}

	//判断监听器是否已经被添加过
	CEventListener *listener = nil;
	for (NSInteger i = 0; i < listeners.count; i++) {
		CEventListener *tempListener = [listeners objectAtIndex:i];
		if (tempListener.target == target) {
			listener = tempListener;
			break;
		}
	}

	NSString *actionStr = NSStringFromSelector(action);

	if (listener) {
		NSMutableArray *actions = listener.actions;
		if (![actions containsObject:actionStr]) {
			[actions addObject:actions];
		}
	}
	else {
		listener = [[CEventListener alloc]init];
		NSMutableArray *actions = [[NSMutableArray alloc]init];
		[actions addObject:actionStr];
		listener.actions = actions;
		[listeners addObject:listener];
	}
}

- (NSMutableDictionary *)eventListeners {
	NSMutableDictionary *eventListener = objc_getAssociatedObject(self, &EVENT_LISTENERS);
	if (!eventListener) {
		eventListener = [[NSMutableDictionary alloc]init];
		objc_setAssociatedObject(self, &EVENT_LISTENERS, eventListener, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return eventListener;
}

@end
