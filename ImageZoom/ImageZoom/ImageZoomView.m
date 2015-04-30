//
//  ImageZoomView.m
//  ImageZoom
//
//  Created by Chentao on 15/4/30.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "ImageZoomView.h"

@interface ImageZoomView ()
@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation ImageZoomView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		// 图片
		_imageView = [[UIImageView alloc] init];
		_imageView.backgroundColor = [UIColor redColor];
//		_imageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:_imageView];


		UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
		doubleTap.numberOfTapsRequired = 2;
		[self addGestureRecognizer:doubleTap];
	}
	return self;
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)doubleTap {
}

- (void)setImage:(UIImage *)image {
	_imageView.image = image;
	[self setNeedsLayout];
}

- (void)layoutSubviews {
	CGSize boundsSize = self.bounds.size;
	CGFloat boundsWidth = boundsSize.width;
	CGFloat boundsHeight = boundsSize.height;

	CGSize imageSize = _imageView.image.size;
	CGFloat imageWidth = imageSize.width;
	CGFloat imageHeight = imageSize.height;

	CGFloat imageRatio = imageWidth / imageHeight;
	CGFloat boundsRatio = boundsWidth / boundsHeight;

	CGRect imageFrame = CGRectZero;

	if (imageRatio > boundsRatio) {
		imageFrame.size.width = boundsWidth;
		imageFrame.size.height = boundsWidth / imageRatio;

		imageFrame.origin.x = 0;
		imageFrame.origin.y = 0.5 * (boundsHeight - imageFrame.size.height);
	}
	else {
		imageFrame.size.height = boundsHeight;
		imageFrame.size.width = boundsHeight * imageRatio;

		imageFrame.origin.x = 0.5 * (boundsWidth - imageFrame.size.width);
		imageFrame.origin.y = 0;
	}

	_imageView.frame = imageFrame;
}

@end
