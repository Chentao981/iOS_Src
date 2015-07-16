//
//  NSObject+EventDispatcher.h
//  EventDispatcher
//
//  Created by Chentao on 15/6/22.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEvent.h"

@interface NSObject (CEventDispatcher)

/**
 *  添加一个事件监听器,默认优先级为1
 *
 *  @param type     时间类型
 *  @param target   事件的响应者
 *  @param action   响应者的方法 方法的格式如: -(void)action:(CEvent *)event;
 */
- (void)addEventListenerWithType:(NSString *)type
                       andTarget:(id)target
                       andAction:(SEL)action
                     andPriority:(NSUInteger)priority;

/**
 *  添加一个事件监听器
 *
 *  @param type     时间类型
 *  @param target   事件的响应者
 *  @param action   响应者的方法 方法的格式如: -(void)action:(CEvent *)event;
 *  @param priority 监听器的优先级
 */
- (void)addEventListenerWithType:(NSString *)type
                       andTarget:(id)target
                       andAction:(SEL)action;

/**
 *  派发一个事件
 *
 *  @param event
 */
- (void)dispatchEvent:(CEvent *)event;

/**
 *  移除事件监听
 *
 *  @param type
 *  @param target
 *  @param action
 */
- (void)removeEventListenerWithType:(NSString *)type andTarget:(id)target action:(SEL)action;

/**
 *  移除所有事件监听
 */
- (void)removeAllEventListener;

@end
