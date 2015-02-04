//
//  UIView+LayoutElement.m
//  CTUILayout
//
//  Created by Chentao on 15/2/3.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "UIView+LayoutElement.h"
#import <objc/runtime.h>

static const char LEFT;
static const char RIGHT;
static const char TOP;
static const char BOTTOM;

static const char VERTICAL_CENTER;
static const char HORIZONTAL_CENTER;
static const char PERCENT_WIDTH;
static const char PERCENT_HEIGHT;

static const char INCLUDE_IN_LAYOUT;

@implementation UIView (LayoutElement)

/**
 * left
 **/
- (void)setLeft:(NSNumber *)left {
	[self setLayoutWithPropertyName:(void *)&LEFT andValue:left];
}

- (NSNumber *)left {
	return objc_getAssociatedObject(self, &LEFT);
}

/**
 * right
 **/
- (void)setRight:(NSNumber *)right {
	[self setLayoutWithPropertyName:(void *)&RIGHT andValue:right];
}

- (NSNumber *)right {
	return objc_getAssociatedObject(self, &RIGHT);
}

/**
 * top
 **/
- (void)setTop:(NSNumber *)top {
	[self setLayoutWithPropertyName:(void *)&TOP andValue:top];
}

- (NSNumber *)top {
	return objc_getAssociatedObject(self, &TOP);
}

/**
 * bottom
 **/
- (void)setBottom:(NSNumber *)bottom {
	[self setLayoutWithPropertyName:(void *)&BOTTOM andValue:bottom];
}

- (NSNumber *)bottom {
	return objc_getAssociatedObject(self, &BOTTOM);
}

/**
 * verticalCenter
 **/
- (void)setVerticalCenter:(NSNumber *)verticalCenter {
	[self setLayoutWithPropertyName:(void *)&VERTICAL_CENTER andValue:verticalCenter];
}

- (NSNumber *)verticalCenter {
	return objc_getAssociatedObject(self, &VERTICAL_CENTER);
}

/**
 * horizontalCenter
 **/
- (void)setHorizontalCenter:(NSNumber *)horizontalCenter {
	[self setLayoutWithPropertyName:(void *)&HORIZONTAL_CENTER andValue:horizontalCenter];
}

- (NSNumber *)horizontalCenter {
	return objc_getAssociatedObject(self, &HORIZONTAL_CENTER);
}

/**
 * percentHeight
 **/
- (void)setPercentHeight:(NSNumber *)percentHeight {
	[self setLayoutWithPropertyName:(void *)&PERCENT_HEIGHT andValue:percentHeight];
}

- (NSNumber *)percentHeight {
	return objc_getAssociatedObject(self, &PERCENT_HEIGHT);
}

/**
 * percentWidth
 **/
- (void)setPercentWidth:(NSNumber *)percentWidth {
	[self setLayoutWithPropertyName:(void *)&PERCENT_WIDTH andValue:percentWidth];
}

- (NSNumber *)percentWidth {
	return objc_getAssociatedObject(self, &PERCENT_WIDTH);
}

/**
 * includeInLayout
 **/
- (void)setIncludeInLayout:(BOOL)includeInLayout {
	NSNumber *oldValue = objc_getAssociatedObject(self, &INCLUDE_IN_LAYOUT);
	if ([oldValue charValue] ^ includeInLayout) {
		objc_setAssociatedObject(self, (void *)&INCLUDE_IN_LAYOUT, [NSNumber numberWithChar:includeInLayout], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		[self setSuperviewNeedsLayout];
	}
}

- (BOOL)includeInLayout {
	NSNumber *value = objc_getAssociatedObject(self, &INCLUDE_IN_LAYOUT);
	return [value charValue];
}

- (void)setLayoutWithPropertyName:(void *)key andValue:(NSNumber *)newValue {
	NSNumber *oldValue = objc_getAssociatedObject(self, key);

	CGFloat oldValueFloatValue = [oldValue floatValue];
	CGFloat newValueFloatValue = [newValue floatValue];

	if (oldValue != newValue) {
		if (nil == newValue || nil == oldValue) {
			objc_setAssociatedObject(self, key, newValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
			[self setSuperviewNeedsLayout];
		}
		else {
			if (oldValueFloatValue != newValueFloatValue) {
				objc_setAssociatedObject(self, key, newValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
				[self setSuperviewNeedsLayout];
			}
		}
	}
	else {
		if (oldValueFloatValue != newValueFloatValue) {
			objc_setAssociatedObject(self, key, newValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
			[self setSuperviewNeedsLayout];
		}
	}
}

- (void)setSuperviewNeedsLayout {
	if (self.superview) {
		[self.superview setNeedsLayout];
	}
}

- (void)setX:(CGFloat)x {
	CGRect newFrame = self.frame;
	newFrame.origin.x = x;
	self.frame = newFrame;
}

- (CGFloat)x {
	return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
	CGRect newFrame = self.frame;
	newFrame.origin.y = y;
	self.frame = newFrame;
}

- (CGFloat)y {
	return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
	CGRect newFrame = self.frame;
	newFrame.size.width = width;
	self.frame = newFrame;
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
	CGRect newFrame = self.frame;
	newFrame.size.height = height;
	self.frame = newFrame;
}

- (CGFloat)height {
	return self.frame.size.height;
}

@end
