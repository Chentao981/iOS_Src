//
//  DrSchoolDetailJsonObj.h
//  Driver
//
//  Created by Chentao on 15/6/17.
//  Copyright (c) 2015年 Driver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "DrDetailResult.h"

@interface DrDetailJsonObj : Jastor


@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) DrDetailResult *result;

@end
