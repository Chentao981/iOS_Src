//
//  BlurView.m
//  BlurView
//
//  Created by Chentao on 15/5/21.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "BlurView.h"
#import "GPUImage.h"
#import "UIImage+BoxBlur.h"
@implementation BlurView


- (void)layoutSubviews {
	[super layoutSubviews];
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	[self snapshot];
}

- (void)snapshot {
	CGRect visibleRect = [self.superview convertRect:self.frame toView:self];
	visibleRect.origin.y += self.frame.origin.y;
	visibleRect.origin.x += self.frame.origin.x;

	CGFloat alpha = self.alpha;
	[self toggleBlurViewsInView:self.superview hidden:YES alpha:alpha];

	UIGraphicsBeginImageContextWithOptions(visibleRect.size, NO, 1.0);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, -visibleRect.origin.x, -visibleRect.origin.y);
	CALayer *layer = self.superview.layer;
	[layer renderInContext:context];

	[self toggleBlurViewsInView:self.superview hidden:NO alpha:alpha];

	__block UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		GPUImageGaussianBlurFilter *blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
		blurFilter.blurRadiusInPixels = 60.0;
		UIImage *blurredImage = [blurFilter imageByFilteringImage:image];

//		NSData *imageData = UIImageJPEGRepresentation(image, 0.01);
//		UIImage *blurredImage = [[UIImage imageWithData:imageData] drn_boxblurImageWithBlur:1.0f];

		dispatch_sync(dispatch_get_main_queue(), ^{
			self.layer.contents = (id)blurredImage.CGImage;
		});
	});
}

- (void)toggleBlurViewsInView:(UIView *)view hidden:(BOOL)hidden alpha:(CGFloat)originalAlpha {
	for (UIView *subview in view.subviews)
		if ([subview isKindOfClass:BlurView.class])
			subview.alpha = hidden ? 0.f : originalAlpha;
}

@end
