//
//  DrBaseinfoarea.h
//  Driver
//
//  Created by Chentao on 15/6/16.
//  Copyright (c) 2015年 Driver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "DrDescarea.h"

@interface DrBaseinfoarea : Jastor
@property (nonatomic, strong) NSArray *tel;
@property (nonatomic, strong) DrButton *rountline;
@property (nonatomic, strong) DrButton *mapaddr;

@end
