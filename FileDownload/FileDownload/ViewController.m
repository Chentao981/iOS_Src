//
//  ViewController.m
//  FileDownload
//
//  Created by 陈涛 on 15/6/7.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "ViewController.h"

#import "FileDownloadHandler.h"

@interface ViewController ()

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
	fileDownloadHandler.saveDirectory = docDir;
	fileDownloadHandler.fileName = @"test.mp4";
	fileDownloadHandler.downloadUrl = url;
	[fileDownloadHandler start:NO];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
