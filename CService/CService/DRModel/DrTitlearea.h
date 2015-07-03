//
//  DrTitlearea.h
//  Driver
//
//  Created by Chentao on 15/6/16.
//  Copyright (c) 2015年 Driver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "DrAction.h"

@interface DrTitlearea : Jastor


@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL ifauthen;
@property (nonatomic, assign) NSUInteger star;
@property (nonatomic, copy) NSString *attentionnum;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, assign) NSUInteger imagecount;
@property (nonatomic, copy) NSString *imageurl;
@property (nonatomic, strong) DrAction *action;


@end
