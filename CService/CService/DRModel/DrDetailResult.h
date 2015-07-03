//
//  DrSchoolDetailResult.h
//  Driver
//
//  Created by Chentao on 15/6/17.
//  Copyright (c) 2015年 Driver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrDetailInfo.h"

#import "Jastor.h"

@interface DrDetailResult : Jastor

@property (nonatomic, strong) DrDetailInfo *info;

@end
