//
//  CService.h
//  CService
//
//  Created by Chentao on 15/7/3.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+CEventDispatcher.h"


#pragma mark-EventType

#define ServiceGETResultSuccess @"serviceGETResultSuccess" //GET请求服务成功，并且数据成功解析
#define ServiceGETResultFail @"serviceGETResultFail"       //GET请求服务失败
#define ServiceGETDataException @"serviceGETDataException" //GET解析返回数据时出现异常

#define ServicePOSTResultSuccess @"servicePOSTResultSuccess" //POST请求服务成功，并且数据成功解析
#define ServicePOSTResultFail @"servicePOSTResultFail"       //POST请求服务失败
#define ServicePOSTDataException @"servicePOSTDataException" //POST解析返回数据时出现异常


/**
 *  CService是对AFNetworking的简单分装，用于请求返回数据类型是Json的服务，提供GET，POST两种请求方式，使用者可以指定
 *数据的返回类型，当服务接口请求完毕时使用事件携带数据通知使用者数据返回.
 */
@interface CService : NSObject

/**
 *  使用GET方式请求数据接口，并返回指定的数据对象
 *
 *  @param url   请求地址
 *  @param dict  请求参数
 *  @param classType  期望数据返回后的数据类型，这个Class应该是Jastor的子类.
 */
-(void)GET:(NSString *)url  parameters:(NSDictionary *)dict resultClassType:(Class)classType;


/**
 *  使用GET方式请求数据接口，并返回指定的数据对象
 *
 *  @param url   请求地址
 *  @param dict  请求参数
 *  @param classType  期望数据返回后的数据类型，这个Class应该是Jastor的子类.
 */
-(void)POST:(NSString *)url  parameters:(NSDictionary *)dict resultClassType:(Class)classType;

@end
