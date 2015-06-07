//
//  ImageZoomView.m
//  ImageZoom
//
//  Created by Chentao on 15/4/30.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "ImageZoomView.h"

#define MaxScaleRatio 1.0f
#define ZoomImageAnimation @"zoomImageAnimation"

@interface ImageZoomView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation ImageZoomView
{
	BOOL imageChange;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.delegate = self;
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = NO;

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
	if (self.imageView.image) {
//		CGPoint location = [doubleTap locationInView:self];
//		NSLog(@"x:%f y:%f", location.x, location.y);
//		[UIView beginAnimations:ZoomImageAnimation context:nil];
//		[UIView setAnimationDelegate:self];
//
//		CGFloat scaleRatio = self.imageView.frame.size.width / self.imageView.image.size.width;
//		if (MaxScaleRatio == scaleRatio) {
//			self.contentOffset = CGPointZero;
//			[self layoutImageView];
//		}
//		else {
//			CGFloat imageViewWidth = self.imageView.frame.size.width;
//
//			CGRect imageFrame = CGRectZero;
//			imageFrame.size.width = MaxScaleRatio * self.imageView.image.size.width;
//			imageFrame.size.height = MaxScaleRatio * self.imageView.image.size.height;
//			self.imageView.frame = imageFrame;
//
//			CGFloat scale = imageFrame.size.width / imageViewWidth;
//			CGPoint scaleLocation = CGPointMake(scale * location.x, scale * location.y);
//			//self.contentOffset = CGPointMake(scaleLocation.x - location.x, scaleLocation.y - location.y);
//
//			[self setContentOffset:CGPointMake(scaleLocation.x - location.x, scaleLocation.y - location.y) animated:YES];
//		}
//		[UIView commitAnimations];

		self.maximumZoomScale = 2.0f;
		//CGPoint touchPoint = [doubleTap locationInView:self];
		CGPoint touchPoint = [doubleTap locationInView:self.imageView];
		CGRect zoomRect = [self zoomRectForScale:self.maximumZoomScale withCenter:touchPoint];

		[self zoomToRect:zoomRect animated:YES];
	}
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
	CGRect zoomRect;
	zoomRect.size.height = self.frame.size.height / scale;
	zoomRect.size.width  = self.frame.size.width  / scale;

	zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
	zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);

	return zoomRect;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return self.imageView;
}

//- (void)animationWillStart:(NSString *)animationID context:(void *)context {
//}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	if ([ZoomImageAnimation isEqualToString:animationID]) {
		self.contentSize = self.imageView.frame.size;
	}
}

- (void)setImage:(UIImage *)image {
	_imageView.image = image;
	imageChange = YES;
	[self setNeedsLayout];
}

- (void)layoutSubviews {
	if (imageChange) {
		[self layoutImageView];
		imageChange = NO;
	}
}

- (void)layoutImageView {
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
