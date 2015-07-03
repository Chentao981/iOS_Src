//
//  DrSchoolDetailInfo.h
//  Driver
//
//  Created by Chentao on 15/6/17.
//  Copyright (c) 2015年 Driver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "DrBaseinfoarea.h"
#import "DrCommentarea.h"
#import "DrDescarea.h"
#import "DrQuestionarea.h"
#import "DrSignuparea.h"
#import "DrTitlearea.h"

@interface DrDetailInfo : Jastor

@property (nonatomic, strong) DrBaseinfoarea *baseinfoarea;
@property (nonatomic, strong) DrCommentarea *commentarea;
@property (nonatomic, strong) DrDescarea *descarea;
@property (nonatomic, strong) DrQuestionarea *questionarea;
@property (nonatomic, strong) DrSignuparea *signuparea;
@property (nonatomic, strong) DrTitlearea *titlearea;

@end
