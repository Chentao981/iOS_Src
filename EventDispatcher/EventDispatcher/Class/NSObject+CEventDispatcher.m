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
@property(nonatomic, strong) id target;
@property(nonatomic, strong) NSMutableArray *actions;
@end

@implementation CEventListener
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
                       andTarget:(id)target
                       andAction:(SEL)action {
  [self addEventListenerWithType:type
                       andTarget:target
                       andAction:action
                     andPriority:1];
}

- (void)addEventListenerWithType:(NSString *)type
                       andTarget:(id)target
                       andAction:(SEL)action
                     andPriority:(NSUInteger)priority {
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
      [actions addObject:actionStr];
    }
  } else {
    listener = [[CEventListener alloc] init];
    listener.target = target;
    NSMutableArray *actions = [[NSMutableArray alloc] init];
    [actions addObject:actionStr];
    listener.actions = actions;
    [listeners addObject:listener];
  }
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
      NSMutableArray *listeners =
          [eventPriority.typeEventListeners objectForKey:priorityKey];
      for (CEventListener *listener in listeners) {
        [self executeListener:listener andEvent:event];
      }
    }
  }
}

- (void)removeEventListenerWithType:(NSString *)type
                          andTarget:(id)target
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
        CEventListener *listener = [listeners objectAtIndex:listenerIndex];
        NSMutableArray *actions = listener.actions;
        if ([actions containsObject:actionStr]) {
          [actions removeObject:actionStr];
        }
        if (actions.count < 1) {
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

- (void)executeListener:(CEventListener *)listener andEvent:(CEvent *)event {
  id target = listener.target;
  if (target) {
    NSArray *actions = listener.actions;
    for (NSString *actionStr in actions) {
      SEL action = NSSelectorFromString(actionStr);
      if ([target respondsToSelector:action]) {
        [target performSelector:action withObject:event];
      }
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
