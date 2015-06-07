//
//  FileDownloadHandler.h
//  FileDownload
//
//  Created by 陈涛 on 15/6/7.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileMark : NSObject <NSCoding>
@property (nonatomic, assign) UInt64 fileSize;
@end


@class FileDownloadHandler;
@protocol FileDownloadHandlerDelegate <NSObject>

/**
 * 文件开始下载时的回调方法;
 * breakpoints 开始下载时的断点;
 * fileSize 文件的总大小;
 **/
- (void)fileDownloadStart:(FileDownloadHandler *)fileDownloadHandler andStartBreakpoints:(UInt64)breakpoints andFileSize:(UInt64)fileSize;

/**
 * 文件下载中的回调方法;
 * downloadFileSize 已经下载的文件大小;
 * fileSize 文件的总大小;
 **/
- (void)fileDownloadProgress:(FileDownloadHandler *)fileDownloadHandler andDownloadFileSize:(UInt64)downloadFileSize andFileSize:(UInt64)fileSize;

/**
 * 文件下载完成的回调方法;
 **/
- (void)fileDownloadComplete:(FileDownloadHandler *)fileDownloadHandler;


/**
 * 文件下载失败的回调方法;
 **/
- (void)fileDownloadFail:(FileDownloadHandler *)fileDownloadHandler andError:(NSError *)error;


@end

@interface FileDownloadHandler : NSObject

@property (nonatomic, weak) id <FileDownloadHandlerDelegate> delegate;

/**
 *要下载的文件的URL
 **/
@property (nonatomic, strong) NSURL *downloadUrl;

/**
 *下载的文件存储到本地的目录
 **/
@property (nonatomic, copy) NSString *saveDirectory;

/**
 *下载的文件存储到本地的名字,如果不设置这个参数,将使用服务器返回的文件名
 **/
@property (nonatomic, copy) NSString *fileName;

/**
 *用户数据
 **/
@property (nonatomic, strong) id userInfo;

/**
   *开始下载文件;
 * breakpoints为YES表示从断点开始下载;
 * breakpoints为NO表示重新下载文件;
 **/
- (void)start:(BOOL)breakpoints;

/**
   *停止下载文件;
 **/
- (void)stop;


@end
