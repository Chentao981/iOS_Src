//
//  DrCommentarea.h
//  Driver
//
//  Created by Chentao on 15/6/16.
//  Copyright (c) 2015年 Driver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrAction.h"
#import "Jastor.h"

@interface DrCommentinfo : Jastor

@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *face;
@property (nonatomic, assign) NSUInteger likecount;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) NSUInteger score;

@end

@interface DrCommentarea : Jastor

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *moretext;
@property (nonatomic, strong) DrAction *action;
@property (nonatomic, strong) DrCommentinfo *commentinfo;

@end
