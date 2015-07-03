//
//  DrQuestionarea.h
//  Driver
//
//  Created by Chentao on 15/6/16.
//  Copyright (c) 2015年 Driver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "DrAction.h"
#import "DrQuestioninfo.h"


@interface DrQuestionarea : Jastor

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *moretext;
@property (nonatomic, strong) DrAction *action;
@property (nonatomic, strong) DrQuestioninfo *questioninfo;

@end
