//
//  FileDownloadManager.m
//  FileDownload
//
//  Created by Chentao on 15/6/8.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "FileDownloadManager.h"

@implementation FileDownloadManager
{
	NSMutableDictionary *downloadHandlers;
}


static FileDownloadManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		isFirstAccess = NO;
		SINGLETON = [[super allocWithZone:NULL] init];
	});

	return SINGLETON;
}

#pragma mark - Life Cycle

+ (id)allocWithZone:(NSZone *)zone {
	return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone {
	return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone {
	return [self sharedInstance];
}

- (id)copy {
	return [[FileDownloadManager alloc] init];
}

- (id)mutableCopy {
	return [[FileDownloadManager alloc] init];
}

- (id)init {
	if (SINGLETON) {
		return SINGLETON;
	}
	if (isFirstAccess) {
		[self doesNotRecognizeSelector:_cmd];
	}
	self = [super init];
	return self;
}

#pragma mark-功能方法
- (FileDownloadHandler *)addDownloadTaskWithId:(NSString *)taskId andDownloadUrl:(NSURL *)downloadUrl andSaveDirectory:(NSString *)saveDirectory andSaveName:(NSString *)saveName {
	if (!downloadHandlers) {
		downloadHandlers = [[NSMutableDictionary alloc]init];
	}
	FileDownloadHandler *fileDownloadHandler = [downloadHandlers objectForKey:taskId];
	if (!fileDownloadHandler) {
		fileDownloadHandler = [[FileDownloadHandler alloc]init];
		fileDownloadHandler.saveDirectory = saveDirectory;
		fileDownloadHandler.fileName = saveName;
		fileDownloadHandler.downloadUrl = downloadUrl;
		[downloadHandlers setObject:fileDownloadHandler forKey:taskId];
	}
	return fileDownloadHandler;
}

- (void)removeDownloadTaskWithId:(NSString *)taskId {
	FileDownloadHandler *fileDownloadHandler = [downloadHandlers objectForKey:taskId];
	if (fileDownloadHandler) {
		[fileDownloadHandler stop];
		[downloadHandlers removeObjectForKey:taskId];
	}
}

- (FileDownloadHandler *)getDownloadTaskWithId:(NSString *)taskId {
	return [downloadHandlers objectForKey:taskId];
}

@end
