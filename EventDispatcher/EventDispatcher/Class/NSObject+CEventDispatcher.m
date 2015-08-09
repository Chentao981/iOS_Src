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

@interface CEventListenerTarget : NSObject
@property(nonatomic, weak) id target;
@property(nonatomic, copy) NSString *action;
@end

@implementation CEventListenerTarget
@end

@interface CEventPriority : NSObject
//用于组织优先级顺序
@property(nonatomic, strong) NSMutableArray *priorityArray;
@property(nonatomic, strong) NSMutableDictionary *typeEventListeners;
@end

@implementation CEventPriority
@end

@implementation NSObject (CEventDispatcher)

- (void)addEventListenerWithType:(NSString *)type
                          target:(id)target
                          action:(SEL)action {
    [self addEventListenerWithType:type
                            target:target
                            action:action
                          priority:1];
}

- (void)addEventListenerWithType:(NSString *)type
                          target:(id)target
                          action:(SEL)action
                        priority:(NSUInteger)priority {
    CEventPriority *eventPriority = [[self eventListeners] objectForKey:type];
    if (!eventPriority) {
        eventPriority = [[CEventPriority alloc] init];
        [[self eventListeners] setObject:eventPriority forKey:type];
        eventPriority.typeEventListeners = [[NSMutableDictionary alloc] init];
        eventPriority.priorityArray = [[NSMutableArray alloc] init];
    }
    
    NSNumber *priorityNumber = [NSNumber numberWithLongLong:priority];
    NSString *priorityKey = [NSString stringWithFormat:@"%@", priorityNumber];
    
    NSMutableArray *listeners =
    [eventPriority.typeEventListeners objectForKey:priorityKey];
    if (!listeners) {
        listeners = [[NSMutableArray alloc] init];
        [eventPriority.typeEventListeners setObject:listeners forKey:priorityKey];
        [eventPriority.priorityArray addObject:priorityNumber];
        NSArray *sortPriorityArray = [eventPriority.priorityArray
                                      sortedArrayUsingSelector:@selector(compare:)];
        eventPriority.priorityArray =
        [NSMutableArray arrayWithArray:sortPriorityArray];
    }
    
    //判断监听器是否已经被添加过
    NSString *actionStr = NSStringFromSelector(action);
    for (NSInteger i = 0; i < listeners.count; i++) {
        CEventListenerTarget *tempListener = [listeners objectAtIndex:i];
        if (tempListener.target == target &&
            [actionStr isEqualToString:tempListener.action]) {
            return;
        }
    }
    
    CEventListenerTarget *listener = [[CEventListenerTarget alloc] init];
    listener.target = target;
    listener.action = actionStr;
    [listeners insertObject:listener atIndex:0];
}

- (void)dispatchEvent:(CEvent *)event {
    event.dispatcherOwner = self;
    NSString *eventType = event.type;
    CEventPriority *eventPriority =
    [[self eventListeners] objectForKey:eventType];
    if (eventPriority) {
        NSArray *priorityArray = eventPriority.priorityArray;
        NSUInteger priorityArrayLastIndex = priorityArray.count - 1;
        for (NSInteger i = priorityArrayLastIndex; i >= 0; i--) {
            NSNumber *priorityNumber = [priorityArray objectAtIndex:i];
            NSString *priorityKey = [NSString stringWithFormat:@"%@", priorityNumber];
            NSMutableArray *listeners = [eventPriority.typeEventListeners objectForKey:priorityKey];
            
            for (NSInteger listenerIndex = listeners.count - 1; listenerIndex >= 0; listenerIndex--) {
                CEventListenerTarget *listener = [listeners objectAtIndex:listenerIndex];
                id target = listener.target;
                if (target) {
                    [self executeListener:listener andEvent:event];
                }else{
                    [listeners removeObject:listener];
                }
            }
        }
    }
}

- (void)removeEventListenerWithType:(NSString *)type
                             target:(id)target
                             action:(SEL)action {
    CEventPriority *eventPriority = [[self eventListeners] objectForKey:type];
    if (eventPriority) {
        NSString *actionStr = NSStringFromSelector(action);
        NSMutableDictionary *typeEventListeners = eventPriority.typeEventListeners;
        
        NSMutableArray *keys = eventPriority.priorityArray;
        for (NSInteger keyIndex = keys.count - 1; keyIndex >= 0; keyIndex--) {
            NSNumber *keyNumber = [keys objectAtIndex:keyIndex];
            NSString *key = [NSString stringWithFormat:@"%@", keyNumber];
            NSMutableArray *listeners = [typeEventListeners objectForKey:key];
            for (NSInteger listenerIndex = listeners.count - 1; listenerIndex >= 0;
                 listenerIndex--) {
                CEventListenerTarget *listener =
                [listeners objectAtIndex:listenerIndex];
                if (listener.target == target &&
                    [listener.action isEqualToString:actionStr]) {
                    [listeners removeObject:listener];
                }
            }
            if (listeners.count < 1) {
                [keys removeObject:keyNumber];
                [typeEventListeners removeObjectForKey:key];
            }
        }
    }
}

- (void)removeAllEventListener {
    objc_setAssociatedObject(self, &EVENT_LISTENERS, nil,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)executeListener:(CEventListenerTarget *)listener
               andEvent:(CEvent *)event {
    id target = listener.target;
    if (target) {
        SEL action = NSSelectorFromString(listener.action);
        if ([target respondsToSelector:action]) {
            [target performSelector:action withObject:event];
        }
    }
}

- (NSMutableDictionary *)eventListeners {
    NSMutableDictionary *eventListener =
    objc_getAssociatedObject(self, &EVENT_LISTENERS);
    if (!eventListener) {
        eventListener = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &EVENT_LISTENERS, eventListener,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return eventListener;
}

@end
