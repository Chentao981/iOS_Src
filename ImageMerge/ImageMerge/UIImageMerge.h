//
//  UIImageMerge.h
//  ImageMerge
//
//  Created by Chentao on 15/5/27.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageScale : NSObject
@property (nonatomic, strong) UIImage *sourceImage;
@property (nonatomic, assign) CGSize scaleSize;
@end



@interface UIImageMerge : NSObject

- (UIImage *)verticalMergeImageWithUIImages:(NSArray *)uiimages andWidth:(CGFloat)width;
- (UIImage *)horizontalMergeImageWithUIImages:(NSArray *)uiimages andHeight:(CGFloat)height;

@end
