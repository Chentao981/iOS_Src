//
//  DrQuestioninfo.h
//  Driver
//
//  Created by Chentao on 15/6/19.
//  Copyright (c) 2015年 Driver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface DrQuestioninfo : Jastor

@property (nonatomic, copy) NSString *answer;
@property (nonatomic, copy) NSString *answername;
@property (nonatomic, copy) NSString *answertime;
@property (nonatomic, copy) NSString *askname;
@property (nonatomic, copy) NSString *asktime;
@property (nonatomic, copy) NSString *qusetion;

@end
