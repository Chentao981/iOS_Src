//
//  MoveCircleView.m
//  BezierPath
//
//  Created by Chentao on 15/4/28.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "MoveCircleView.h"

@implementation MoveCircleView
{
	CGPoint beganPoint;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		self.bgColor = [UIColor redColor];
	}
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	beganPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint newPoint = [touch locationInView:self];

	CGFloat offsetx = newPoint.x - beganPoint.x;
	CGFloat offsety = newPoint.y - beganPoint.y;
	self.center = CGPointMake(self.center.x + offsetx, self.center.y + offsety);
	if (self.delegate && [self.delegate respondsToSelector:@selector(touchesMoved:)]) {
		[self.delegate touchesMoved:self];
	}
}

- (void)setBgColor:(UIColor *)bgColor {
	_bgColor = bgColor;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	[self.bgColor setFill];
	UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
	[path fill];
}

@end
