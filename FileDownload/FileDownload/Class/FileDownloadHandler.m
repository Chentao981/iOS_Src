//
//  FileDownloadHandler.m
//  FileDownload
//
//  Created by 陈涛 on 15/6/7.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "FileDownloadHandler.h"
#import <CommonCrypto/CommonCrypto.h>

#define CustomErrorDomain @"FileDownloadHandler"

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
	NSURLConnection *urlConnection;
	NSFileHandle *fileHandle;
	UInt64 breakpoints;

	NSString *markFileName;
}

- (void)start {
	if (self.downloadUrl && ![self stringIsEmpty:self.saveDirectory]) {
		if (![self stringIsEmpty:self.fileName]) {
			//如果fileName不为空
			NSString *saveFilePath = [self.saveDirectory stringByAppendingPathComponent:self.fileName];
			if ([self fileExistsAtPath:saveFilePath]) {
				//获取标记文件
				markFileName = [self md5:self.downloadUrl.absoluteString];
				NSString *markFilePath = [self.saveDirectory stringByAppendingPathComponent:markFileName];
				if ([self fileExistsAtPath:markFilePath]) {
					FileMark *fileMark = [NSKeyedUnarchiver unarchiveObjectWithFile:markFilePath];
					if (fileMark) {
						UInt64 fileSize = fileMark.fileSize;
						//获取已经下载的文件大小
						NSFileHandle *downloadFileHandle = [NSFileHandle fileHandleForWritingAtPath:saveFilePath];
						UInt64 downloadFileSize = [downloadFileHandle seekToEndOfFile];
						if (downloadFileSize ==  fileSize) {
							//文件已经下载完成
							if (self.delegate && [self.delegate respondsToSelector:@selector(fileDownloadComplete:)]) {
								[self.delegate fileDownloadComplete:self];
							}
						}
						else if (downloadFileSize <  fileSize) {
							//文件未下载完成,从断点开始下载
							[self startDownloadWithURL:self.downloadUrl andBreakpoints:downloadFileSize];
						}
						else {
							if (self.delegate && [self.delegate respondsToSelector:@selector(fileDownloadFail:andError:)]) {
								NSError *error = [NSError errorWithDomain:CustomErrorDomain code:FileDownloadErrorTypeBreakpointsOutOfRange userInfo:nil];
								[self.delegate fileDownloadFail:self andError:error];
							}
						}
					}
					else {
						//如果mark文件不存在，则直接开始下载
						[self startDownloadWithURL:self.downloadUrl andBreakpoints:0];
					}
				}
				else {
					//如果mark文件不存在，则直接开始下载
					[self startDownloadWithURL:self.downloadUrl andBreakpoints:0];
				}
			}
			else {
				//如果文件不存在，则直接开始下载
				[self startDownloadWithURL:self.downloadUrl andBreakpoints:0];
			}
		}
		else {
			//如果文件名称为空则直接开始下载，下载完成后的文件名为服务器上的文件名
			[self startDownloadWithURL:self.downloadUrl andBreakpoints:0];
		}
	}
	else {
		if (self.delegate && [self.delegate respondsToSelector:@selector(fileDownloadFail:andError:)]) {
			if (!self.downloadUrl) {
				NSError *error = [NSError errorWithDomain:CustomErrorDomain code:FileDownloadErrorTypeInvalidDownloadURL userInfo:nil];
				[self.delegate fileDownloadFail:self andError:error];
				return;
			}
			if ([self stringIsEmpty:self.saveDirectory]) {
				NSError *error = [NSError errorWithDomain:CustomErrorDomain code:FileDownloadErrorTypeInvalidSaveDirectory userInfo:nil];
				[self.delegate fileDownloadFail:self andError:error];
				return;
			}
		}
	}
}

- (void)stop {
	if (urlConnection) {
		[urlConnection cancel];
	}
	if (fileHandle) {
		[fileHandle closeFile];
	}
}

#pragma mark- NSURLConnectionDataDelegate代理方法

//当接收到服务器的响应（连通了服务器）时会调用
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	if ([self stringIsEmpty:self.fileName]) {
		self.fileName = response.suggestedFilename;
	}

	NSString *saveFilePath = [self.saveDirectory stringByAppendingPathComponent:self.fileName];

	if ([self stringIsEmpty:markFileName]) {
		markFileName = [self md5:self.downloadUrl.absoluteString];
	}

	if (0 == breakpoints) {
		UInt64 fileSize = response.expectedContentLength;
		//从头开始下载文件
		[self createFileWithDirectory:self.saveDirectory andFileName:self.fileName andMarkName:markFileName andFileSize:fileSize];
		if (self.delegate && [self.delegate respondsToSelector:@selector(fileDownloadStart:andStartBreakpoints:andFileSize:)]) {
			[self.delegate fileDownloadStart:self andStartBreakpoints:breakpoints andFileSize:fileSize];
		}
	}
	else {
		NSString *markFilePath = [self.saveDirectory stringByAppendingPathComponent:markFileName];
		if ([self fileExistsAtPath:saveFilePath] && [self fileExistsAtPath:markFilePath]) {
			FileMark *fileMark = [NSKeyedUnarchiver unarchiveObjectWithFile:markFilePath];
			if (fileMark) {
				if (self.delegate && [self.delegate respondsToSelector:@selector(fileDownloadStart:andStartBreakpoints:andFileSize:)]) {
					[self.delegate fileDownloadStart:self andStartBreakpoints:breakpoints andFileSize:fileMark.fileSize];
				}
			}
			else {
				//下载出错，标记文件不存在
				[connection cancel];
				if (self.delegate && [self.delegate respondsToSelector:@selector(fileDownloadFail:andError:)]) {
					NSError *error = [NSError errorWithDomain:CustomErrorDomain code:FileDownloadErrorTypeBreakpointsFileNotExist userInfo:nil];
					[self.delegate fileDownloadFail:self andError:error];
				}
			}
		}
		else {
			//下载出错，保存在本地的文件不存在
			[connection cancel];
			if (self.delegate && [self.delegate respondsToSelector:@selector(fileDownloadFail:andError:)]) {
				NSError *error = [NSError errorWithDomain:CustomErrorDomain code:FileDownloadErrorTypeBreakpointsFileNotExist userInfo:nil];
				[self.delegate fileDownloadFail:self andError:error];
			}
		}
	}
	fileHandle = [NSFileHandle fileHandleForWritingAtPath:saveFilePath];
}

//当接收到服务器的数据时会调用（可能会被调用多次，每次只传递部分数据）
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	UInt64 downloadFileSize = [fileHandle seekToEndOfFile];
	[fileHandle writeData:data];
	downloadFileSize += data.length;

	if (self.delegate && [self.delegate respondsToSelector:@selector(fileDownloadProgress:andDownloadFileSize:andFileSize:)]) {
		NSString *markFilePath = [self.saveDirectory stringByAppendingPathComponent:markFileName];
		FileMark *fileMark = [NSKeyedUnarchiver unarchiveObjectWithFile:markFilePath];
		[self.delegate fileDownloadProgress:self andDownloadFileSize:downloadFileSize andFileSize:fileMark.fileSize];
	}
}

//当服务器的数据加载完毕时就会调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	if (fileHandle) {
		[fileHandle closeFile];
	}
	if (self.delegate && [self.delegate respondsToSelector:@selector(fileDownloadComplete:)]) {
		[self.delegate fileDownloadComplete:self];
	}
}

//请求错误（失败）的时候调用（请求超时\断网\没有网\，一般指客户端错误）
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	if (fileHandle) {
		[fileHandle closeFile];
	}
	[connection cancel];
}

#pragma mark-

- (void)dealloc {
	[urlConnection cancel];
	if (fileHandle) {
		[fileHandle closeFile];
	}
}

- (void)createFileWithDirectory:(NSString *)directory andFileName:(NSString *)name andMarkName:(NSString *)markName andFileSize:(UInt64)fileSize {
	NSString *saveFilePath = [directory stringByAppendingPathComponent:name];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	[fileManager createFileAtPath:saveFilePath contents:nil attributes:nil];

	NSString *markFilePath = [directory stringByAppendingPathComponent:markName];
	FileMark *fileMark = [[FileMark alloc]init];
	fileMark.fileSize = fileSize;
	[NSKeyedArchiver archiveRootObject:fileMark toFile:markFilePath];
}

/**
 * 开始下载文件
 * url
 * breakpoints 下载开始点
 **/
- (void)startDownloadWithURL:(NSURL *)url andBreakpoints:(UInt64)point {
	breakpoints = point;
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.downloadUrl];
	if (breakpoints > 0) {
		NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", point];
		[request setValue:requestRange forHTTPHeaderField:@"Range"];
	}
	urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
	[urlConnection start];
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

- (BOOL)fileExistsAtPath:(NSString *)filePath {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	return [fileManager fileExistsAtPath:filePath];
}

- (BOOL)stringIsEmpty:(NSString *)string {
	if (string && string.length > 0) {
		return NO;
	}
	return YES;
}

@end
