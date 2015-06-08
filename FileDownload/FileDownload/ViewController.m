//
//  ViewController.m
//  FileDownload
//
//  Created by 陈涛 on 15/6/7.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "ViewController.h"

#import "FileDownloadHandler.h"

@interface ViewController () <FileDownloadHandlerDelegate>

@end

@implementation ViewController
{
	FileDownloadHandler *fileDownloadHandler;
}


- (void)viewDidLoad {
	[super viewDidLoad];

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDir = [paths objectAtIndex:0];

	NSString *fileUrl = @"http://api.jxedt.com/video/tech/?id=10003";
	NSURL *url = [NSURL URLWithString:fileUrl];

	fileDownloadHandler = [[FileDownloadHandler alloc]init];
	fileDownloadHandler.delegate = self;
	fileDownloadHandler.saveDirectory = docDir;
	fileDownloadHandler.fileName = @"test.mp4";
	fileDownloadHandler.downloadUrl = url;
	[fileDownloadHandler start];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[fileDownloadHandler stop];
}

#pragma mark-
/**
 * 文件开始下载时的回调方法;
 * breakpoints 开始下载时的断点;
 * fileSize 文件的总大小;
 **/
- (void)fileDownloadStart:(FileDownloadHandler *)fileDownloadHandler andStartBreakpoints:(UInt64)breakpoints andFileSize:(UInt64)fileSize {
	NSLog(@"开始下载文件 fileSize：%llu  breakpoints：%llu", fileSize, breakpoints);
}

/**
 * 文件下载中的回调方法;
 * downloadFileSize 已经下载的文件大小;
 * fileSize 文件的总大小;
 **/
- (void)fileDownloadProgress:(FileDownloadHandler *)fileDownloadHandler andDownloadFileSize:(UInt64)downloadFileSize andFileSize:(UInt64)fileSize {
	NSLog(@"下载文件中 fileSize：%llu  downloadFileSize：%llu progress:%f", fileSize, downloadFileSize, (double)downloadFileSize / fileSize);
}

/**
 * 文件下载完成的回调方法;
 **/
- (void)fileDownloadComplete:(FileDownloadHandler *)fileDownloadHandler {
	NSLog(@"下载完成.");
}

/**
 * 文件下载失败的回调方法;
 **/
- (void)fileDownloadFail:(FileDownloadHandler *)fileDownloadHandler andError:(NSError *)error {
	NSLog(@"下载出错了....");
}

@end
