//
//  CEvent.h
//  EventDispatcher
//
//  Created by Chentao on 15/6/22.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CEvent : NSObject


/**
 *  事件的派发者
 */
@property (nonatomic, strong) id dispatcherOwner;



/**
 *  事件类型
 */
@property (nonatomic, copy) NSString *type;

/**
 *  事件所携带的数据
 */
@property (nonatomic, strong) id data;

- (instancetype)initWithType:(NSString *)type andData:(id)data;

/**
 *  复制一个事件
 *
 *  @return
 */
- (CEvent *)clone;

@end
