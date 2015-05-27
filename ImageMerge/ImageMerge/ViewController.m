//
//  ViewController.m
//  ImageMerge
//
//  Created by Chentao on 15/5/27.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "ViewController.h"

#import "UIImageMerge.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	UIImage *image1 = [UIImage imageNamed:@"image1.jpg"];
	UIImage *image2 = [UIImage imageNamed:@"image4.jpg"];
	UIImage *image3 = [UIImage imageNamed:@"image3.jpg"];

	NSArray *images = [NSArray arrayWithObjects:image1, image2, image3, nil];
	UIImageMerge *imageMerge = [[UIImageMerge alloc]init];
//	UIImage *targetImage = [imageMerge verticalMergeImageWithUIImages:images andWidth:100.0f];
	UIImage *targetImage = [imageMerge horizontalMergeImageWithUIImages:images andHeight:100];

	UIImageView *imageView = [[UIImageView alloc]initWithImage:targetImage];
	[self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (UIImage *)mergeImageWithUIImages:(NSArray *)uiimages {
	UIImage *image;

	return image;
}

@end
