//
//  FileDownloadManager.h
//  FileDownload
//
//  Created by Chentao on 15/6/8.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileDownloadHandler.h"

@interface FileDownloadManager : NSObject

/**
 *  单例,建议通过此方法获得此类的实例.
 *
 *  @return 返回此类的唯一实例.
 */
+ (FileDownloadManager *)sharedInstance;

/**
 *  添加一个下载任务,这只是添加任务,使用者需要手动调用start方法使下载开始.
 *  如果指定的taskId已存在,则返回对应的FileDownloadHandler对象,不会创建新的FileDownloadHandler对象.
 *
 *  @param taskId        任务ID
 *  @param downloadUrl   远程下载文件的地址
 *  @param saveDirectory 保存到本地的目录
 *  @param saveName      保存到本地的文件名
 *
 *  @return 返回一个下载处理对象，拿到下载处理对象后可以监听下载情况.
 */
- (FileDownloadHandler *)addDownloadTaskWithId:(NSString *)taskId andDownloadUrl:(NSURL *)downloadUrl andSaveDirectory:(NSString *)saveDirectory andSaveName:(NSString *)saveName;


/**
 *  删除一个下载任务,调用此方法后,如果要删除的任务存在,则先停止任务
 *
 *  @param taskId taskId 任务ID
 */
- (void)removeDownloadTaskWithId:(NSString *)taskId;


/**
 *  根据ID获得一个下载任务
 *
 *  @param taskId 任务ID
 *
 *  @return 返回下载处理对象，如果不存在返回nil.
 */
- (FileDownloadHandler *)getDownloadTaskWithId:(NSString *)taskId;


@end
