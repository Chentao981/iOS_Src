//
//  CircleLayer.m
//  Loading2
//
//  Created by Chentao on 15/5/8.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "CircleLayer.h"
#import <UIKit/UIKit.h>
@implementation CircleLayer

- (instancetype)init {
	self = [super init];
	if (self) {
		self.delegate = self;
	}
	return self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
	CGRect frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = ctx;

	UIColor *gradientColor = [[UIColor blackColor]colorWithAlphaComponent:1.0];
	UIColor *gradientColor2 = [[UIColor blackColor]colorWithAlphaComponent:0.0];

	CGFloat gradientLocations[] = { 0, 1 };
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)gradientColor.CGColor, (id)gradientColor2.CGColor], gradientLocations);

	CGRect rectangleRect = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), frame.size.width, frame.size.height);
	CGContextSaveGState(context);
	CGContextDrawRadialGradient(context, gradient,
	                            CGPointMake(CGRectGetMidX(rectangleRect), CGRectGetMidY(rectangleRect)), 0.5 * frame.size.width - 4.0,
	                            CGPointMake(CGRectGetMidX(rectangleRect), CGRectGetMidY(rectangleRect)), 0.5 * frame.size.width - 1.0,
	                            kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
	CGContextRestoreGState(context);

	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
}

@end
