//
//  DrAction.h
//  Driver
//
//  Created by Chentao on 15/6/16.
//  Copyright (c) 2015年 Driver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface DrCoordinate : Jastor
@property (nonatomic, assign) float lat;
@property (nonatomic, assign) float lon;
@end

@interface DrAction : Jastor

@property (nonatomic, copy) NSString *actiontype;
@property (nonatomic, copy) NSString *pagetype;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) DrCoordinate *extparam;

@end
