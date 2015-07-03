//
//  ViewController.m
//  CService
//
//  Created by Chentao on 15/7/3.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "ViewController.h"
#import "CService.h"
#import "DrDetailJsonObj.h"
@interface ViewController ()

@end

@implementation ViewController
{
    CService *service;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    service=[[CService alloc]init];
    [service addEventListenerWithType:ServiceGETResultSuccess andTarget:self andAction:@selector(onResultSuccess:) andPriority:1];
    [service addEventListenerWithType:ServiceGETResultFail andTarget:self andAction:@selector(onResultFail:) andPriority:1];
    [service addEventListenerWithType:ServiceGETDataException andTarget:self andAction:@selector(onDataException:) andPriority:1];
    
    NSString *url=@"http://api.jxedt.test.58v5.cn/detail/127/?type=jx&debug=true";
    [service GET:url parameters:nil resultClassType:[DrDetailJsonObj class]];
}


-(void)onResultSuccess:(CEvent *)event{
    DrDetailJsonObj *jsonObj=event.data;
    
    
}

-(void)onResultFail:(CEvent *)event{
    
}

-(void)onDataException:(CEvent *)event{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
