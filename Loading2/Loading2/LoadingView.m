//
//  LoadingView.m
//  Loading2
//
//  Created by Chentao on 15/5/8.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "LoadingView.h"
#import "CircleLayer.h"

#define Max_Angle 12.566370614359172 //4*M_PI

#define OffsetAngle  (M_PI / 180) * 10.0 //回弹角度

@interface LoadingView ()
@property (nonatomic, strong) CircleLayer *maskLayer;
@end

@implementation LoadingView
{
	CGPoint centerPoint;
	CGFloat radius;
	BOOL showLoading;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		_lineWidth = 4.0;
		_duration = 2.5;

		self.backgroundColor = [UIColor clearColor];
		_maskLayer = [[CircleLayer alloc]init];
		[self.layer addSublayer:_maskLayer];
		self.layer.mask = _maskLayer;
	}
	return self;
}

- (void)showLoading:(BOOL)show {
	if (show) {
		showLoading = YES;
		[self setNeedsDisplay];
	}
	else {
		[self.maskLayer removeAllAnimations];
	}
}

- (void)showAnimation {
	CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	positionAnimation.values = [self generateKeyframePositionValues:Max_Angle andCenterPoint:centerPoint andRadius:radius andDuration:_duration];

	CAKeyframeAnimation *radiusAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size"];
	radiusAnimation.values = [self generateKeyframeRadiusValues:Max_Angle andRadius:radius andDuration:_duration];

	CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc]init];

	animationGroup.timingFunction = [[CAMediaTimingFunction alloc]initWithControlPoints:0.6:0:0.4:1];
	animationGroup.duration = _duration;
	animationGroup.repeatCount = HUGE_VALF;
	NSArray *animations = [NSArray arrayWithObjects:positionAnimation, radiusAnimation, nil];
	[animationGroup setAnimations:animations];
	[self.maskLayer addAnimation:animationGroup forKey:nil];
}

//生成Mask的radius关键帧
- (NSArray *)generateKeyframeRadiusValues:(CGFloat)angle andRadius:(CGFloat)r andDuration:(CGFloat)duration {
	//帧频
	NSUInteger keyFrame = 35;
	//总帧数
	NSUInteger keyFrameCount = keyFrame * duration;

	NSMutableArray *keyframeValues = [NSMutableArray arrayWithCapacity:keyFrameCount];

	//步长
	CGFloat stepValue = angle / keyFrameCount;

	for (NSUInteger i = 0; i <= keyFrameCount; i++) {
		CGFloat maskRadius = 1.8 * r * fabs(sin(2 * M_PI * (stepValue * i / Max_Angle))) + 0.5*_lineWidth;
		[keyframeValues addObject:[NSValue valueWithCGSize:CGSizeMake(2 * maskRadius, 2 * maskRadius)]];
	}
	return keyframeValues;
}

//生成Mask的position关键帧
- (NSArray *)generateKeyframePositionValues:(CGFloat)angle andCenterPoint:(CGPoint)center andRadius:(CGFloat)r andDuration:(CGFloat)duration {
	//帧频
	NSUInteger keyFrame = 35;
	//总帧数
	NSUInteger keyFrameCount = keyFrame * duration;

	NSMutableArray *keyframeValues = [NSMutableArray arrayWithCapacity:keyFrameCount];

	//步长
	CGFloat stepValue = angle / keyFrameCount;

	//回弹角度
	CGFloat offsetAngle = OffsetAngle;

	for (NSUInteger i = 0; i <= keyFrameCount; i++) {
		CGPoint newPoint = CGPointZero;

		CGFloat newAngle = fabs((Max_Angle + offsetAngle) / (Max_Angle - offsetAngle) * (stepValue * i)  - offsetAngle) - offsetAngle - M_PI_2;

		newPoint.x = center.x + r * cos(newAngle);
		newPoint.y = center.y + r * sin(newAngle);
		[keyframeValues addObject:[NSValue valueWithCGPoint:newPoint]];
	}
	return keyframeValues;
}

- (void)drawRect:(CGRect)rect {
	CGFloat width = self.bounds.size.width;
	CGFloat height = self.bounds.size.height;

	UIBezierPath *linepath = [UIBezierPath bezierPath];
	linepath.lineWidth = _lineWidth;
	centerPoint = CGPointMake(0.5 * width, 0.5 * height);
	radius = (MIN(width, height) - _lineWidth - 2.0) * 0.5;
	[linepath addArcWithCenter:centerPoint radius:radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
	[[UIColor colorWithRed:1.0 green:68 / 255.0 blue:41 / 255.0 alpha:1.0]setStroke];
	[linepath stroke];

	_maskLayer.frame = CGRectMake(0, 0, 20, 20);
	_maskLayer.position = centerPoint;
	[_maskLayer setNeedsDisplay];

	if (showLoading) {
		showLoading = NO;
		[self showAnimation];
	}
}

- (CAShapeLayer *)shapeLayer {
	return (CAShapeLayer *)self.layer;
}

+ (Class)layerClass {
	return [CAShapeLayer class];
}

@end
