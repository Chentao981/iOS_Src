//
//  CService.m
//  CService
//
//  Created by Chentao on 15/7/3.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "CService.h"
#import "AFNetworking.h"
#import "Jastor.h"

@implementation CService
{
    NSMutableArray *requestOperationManagers;
}

-(void)GET:(NSString *)url parameters:(NSDictionary *)dict resultClassType:(Class)ClassType{
    if (!requestOperationManagers) {
        requestOperationManagers=[[NSMutableArray alloc]init];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    __block CService *service=self;
    
    [manager GET:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [requestOperationManagers removeObject:manager];
        if (responseObject) {
            @try {
                Jastor *jsonObj=[[ClassType alloc]initWithDictionary:responseObject];
                CEvent *event=[[CEvent alloc]init];
                event.type=ServiceGETResultSuccess;
                event.data=jsonObj;
                [service dispatchEvent:event];
            }
            @catch (NSException *exception) {
                CEvent *event=[[CEvent alloc]init];
                event.type=ServiceGETDataException;
                [service dispatchEvent:event];
            }
            @finally {
                
            }
        }else{
            CEvent *event=[[CEvent alloc]init];
            event.type=ServiceGETResultFail;
            [service dispatchEvent:event];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [requestOperationManagers removeObject:manager];
        CEvent *event=[[CEvent alloc]init];
        event.type=ServiceGETResultFail;
        [service dispatchEvent:event];
    }];
    
    [requestOperationManagers addObject:manager];
}


-(void)POST:(NSString *)url parameters:(NSDictionary *)dict resultClassType:(Class)ClassType{
    if (!requestOperationManagers) {
        requestOperationManagers=[[NSMutableArray alloc]init];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    __block CService *service=self;
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [requestOperationManagers removeObject:manager];
        if (responseObject) {
            @try {
                Jastor *jsonObj=[[ClassType alloc]initWithDictionary:responseObject];
                CEvent *event=[[CEvent alloc]init];
                event.type=ServicePOSTResultSuccess;
                event.data=jsonObj;
                [service dispatchEvent:event];
            }
            @catch (NSException *exception) {
                CEvent *event=[[CEvent alloc]init];
                event.type=ServicePOSTDataException;
                [service dispatchEvent:event];
            }
            @finally {
                
            }
        }else{
            CEvent *event=[[CEvent alloc]init];
            event.type=ServicePOSTResultFail;
            [service dispatchEvent:event];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [requestOperationManagers removeObject:manager];
        CEvent *event=[[CEvent alloc]init];
        event.type=ServicePOSTResultFail;
        [service dispatchEvent:event];
    }];
    
    [requestOperationManagers addObject:manager];
}

@end
