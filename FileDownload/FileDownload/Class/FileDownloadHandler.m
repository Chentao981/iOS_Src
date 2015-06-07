//
//  FileDownloadHandler.m
//  FileDownload
//
//  Created by 陈涛 on 15/6/7.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "FileDownloadHandler.h"
#import <CommonCrypto/CommonCrypto.h>

#define FIELD_FILESIZE @"fileSize"

#pragma mark- FileMark 定义
@implementation FileMark

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:[NSNumber numberWithUnsignedLongLong:self.fileSize] forKey:FIELD_FILESIZE];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	if (self) {
		self.fileSize = [[aDecoder decodeObjectForKey:FIELD_FILESIZE] longLongValue];
	}
	return self;
}

@end


@interface FileDownloadHandler (NSURLConnectionDataDelegate)

@end

@implementation FileDownloadHandler
{
	NSURLConnection *connection;
	NSFileHandle *fileHandle;
}

- (void)start:(BOOL)breakpoints {
	if (self.downloadUrl && self.saveDirectory) {
		NSURLRequest *request = [NSURLRequest requestWithURL:self.downloadUrl];
		if (breakpoints) {
		}
		else {
		}
		connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
		[connection start];
	}
	else {
		if (self.delegate && [self.delegate respondsToSelector:@selector(fileDownloadFail:andError:)]) {
			[self.delegate fileDownloadFail:self andError:nil];
		}
	}
}

- (void)stop {
}

#pragma mark- NSURLConnectionDataDelegate代理方法

//当接收到服务器的响应（连通了服务器）时会调用
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	UInt64 fileSize = response.expectedContentLength;
	if (self.delegate && [self.delegate respondsToSelector:@selector(fileDownloadStart:andStartBreakpoints:andFileSize:)]) {
		[self.delegate fileDownloadStart:self andStartBreakpoints:0 andFileSize:fileSize];
	}

	NSString *saveFilePath = [self.saveDirectory stringByAppendingPathComponent:self.fileName];
	NSFileManager *fileManager = [NSFileManager defaultManager];

	if (![fileManager isExecutableFileAtPath:saveFilePath]) {
		//如果文件不存在则创建一个
		[fileManager createFileAtPath:saveFilePath contents:nil attributes:nil];

		//说明文件是第一次下载，创建标记文件
		NSString *markFileName = [self md5:self.downloadUrl.absoluteString];
		NSString *markFilePath = [self.saveDirectory stringByAppendingPathComponent:markFileName];

		FileMark *fileMark = [[FileMark alloc]init];
		fileMark.fileSize = fileSize;
		[NSKeyedArchiver archiveRootObject:fileMark toFile:markFilePath];
	}
	else {
	}
	fileHandle = [NSFileHandle fileHandleForWritingAtPath:saveFilePath];
}

//当接收到服务器的数据时会调用（可能会被调用多次，每次只传递部分数据）
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"length:%lu", (unsigned long)data.length);

	[fileHandle seekToEndOfFile];
	[fileHandle writeData:data];
}

//当服务器的数据加载完毕时就会调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	if (fileHandle) {
		[fileHandle closeFile];
	}
}

//请求错误（失败）的时候调用（请求超时\断网\没有网\，一般指客户端错误）
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	if (fileHandle) {
		[fileHandle closeFile];
	}
}

/**
 * 字符串转MD5
 **/
- (NSString *)md5:(NSString *)str {
	if (str == nil || [str length] == 0) {
		return str;
	}
	const char *cStr = [str UTF8String];
	unsigned char result[16];
	CC_MD5(cStr, (unsigned int)strlen(cStr), result);
	return [NSString stringWithFormat:
	        @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
	        result[0], result[1], result[2], result[3],
	        result[4], result[5], result[6], result[7],
	        result[8], result[9], result[10], result[11],
	        result[12], result[13], result[14], result[15]
	];
}

@end
