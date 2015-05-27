//
//  UIImageMerge.m
//  ImageMerge
//
//  Created by Chentao on 15/5/27.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "UIImageMerge.h"

@implementation ImageScale
@end

@implementation UIImageMerge


- (UIImage *)verticalMergeImageWithUIImages:(NSArray *)uiimages andWidth:(CGFloat)width {
	//计算最终生成图片的尺寸
	NSMutableArray *scaleImages = [[NSMutableArray alloc]initWithCapacity:uiimages.count];
	CGSize imageSize = CGSizeZero;
	imageSize.width = width;
	for (UIImage *sourceImage in uiimages) {
		CGFloat scaleHeight = [self getScaleHeightWithSourceSize:sourceImage.size andWidth:width];
		imageSize.height += scaleHeight;

		ImageScale *imageScale = [[ImageScale alloc]init];
		imageScale.scaleSize = CGSizeMake(width, scaleHeight);
		imageScale.sourceImage = sourceImage;
		[scaleImages addObject:imageScale];
	}
	// 创建一个bitmap的context
	// 并把它设置成为当前正在使用的context
	UIGraphicsBeginImageContext(imageSize);
	// 绘制改变大小的图片
	CGFloat tempY = 0.0;
	for (ImageScale *imageScale in scaleImages) {
		[imageScale.sourceImage drawInRect:CGRectMake(0, tempY, imageScale.scaleSize.width, imageScale.scaleSize.height)];
		tempY += imageScale.scaleSize.height;
	}
	// 从当前context中创建一个改变大小后的图片
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	//// 使当前的context出堆栈
	UIGraphicsEndImageContext();
	// 返回新的改变大小后的图片
	return newImage;
}

- (UIImage *)horizontalMergeImageWithUIImages:(NSArray *)uiimages andHeight:(CGFloat)height {
	//计算最终生成图片的尺寸
	NSMutableArray *scaleImages = [[NSMutableArray alloc]initWithCapacity:uiimages.count];
	CGSize imageSize = CGSizeZero;
	imageSize.height = height;
	for (UIImage *sourceImage in uiimages) {
		CGFloat scaleWidth = [self getScaleWidthWithSourceSize:sourceImage.size andHeight:height];
		imageSize.width += scaleWidth;

		ImageScale *imageScale = [[ImageScale alloc]init];
		imageScale.scaleSize = CGSizeMake(scaleWidth, height);
		imageScale.sourceImage = sourceImage;
		[scaleImages addObject:imageScale];
	}
	// 创建一个bitmap的context
	// 并把它设置成为当前正在使用的context
	UIGraphicsBeginImageContext(imageSize);
	// 绘制改变大小的图片
	CGFloat tempX = 0.0;
	for (ImageScale *imageScale in scaleImages) {
		[imageScale.sourceImage drawInRect:CGRectMake(tempX, 0, imageScale.scaleSize.width, imageScale.scaleSize.height)];
		tempX += imageScale.scaleSize.width;
	}
	// 从当前context中创建一个改变大小后的图片
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	//// 使当前的context出堆栈
	UIGraphicsEndImageContext();
	// 返回新的改变大小后的图片
	return newImage;
}

/**
 * 根据原尺寸，及目标宽度计算出目标高度
 **/
- (CGFloat)getScaleHeightWithSourceSize:(CGSize)sourceSize andWidth:(CGFloat)width {
	CGFloat ratio = sourceSize.width / sourceSize.height;
	return width / ratio;
}

/**
 * 根据原尺寸，及目标高度计算出目标宽度
 **/
- (CGFloat)getScaleWidthWithSourceSize:(CGSize)sourceSize andHeight:(CGFloat)height {
	CGFloat ratio = sourceSize.width / sourceSize.height;
	return height * ratio;
}

@end
