//
//  DrDescarea.h
//  Driver
//
//  Created by Chentao on 15/6/16.
//  Copyright (c) 2015年 Driver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

#import "DrAction.h"

@interface DrButton : Jastor

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) DrAction *action;

@end


@interface DrDescarea : Jastor
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) DrButton *morebutton;
@property (nonatomic, strong) DrButton *jxnewsbutton;
@property (nonatomic, strong) DrButton *characterbutton;

@end
