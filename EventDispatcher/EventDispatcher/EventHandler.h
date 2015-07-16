//
//  EventHandler.h
//  EventDispatcher
//
//  Created by Chentao on 15/7/16.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+CEventDispatcher.h"

@interface EventHandler : NSObject

@property(nonatomic, strong) NSObject *target;

@end
