//
//  DrSignuparea.h
//  Driver
//
//  Created by Chentao on 15/6/16.
//  Copyright (c) 2015年 Driver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface DrSignup : Jastor
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *type;
@end



@interface DrSignuparea : Jastor

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *list;

@end
