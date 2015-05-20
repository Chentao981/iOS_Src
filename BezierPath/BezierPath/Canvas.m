//
//  Canvas.m
//  BezierPath
//
//  Created by Chentao on 15/4/28.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "Canvas.h"
#import "MoveCircleView.h"

@interface Canvas () <MoveCircleViewDelegate>

@property (nonatomic, strong) MoveCircleView *startPointView;
@property (nonatomic, strong) MoveCircleView *endPointView;

@property (nonatomic, strong) MoveCircleView *controlPointView1;
@property (nonatomic, strong) MoveCircleView *controlPointView2;

@end

@implementation Canvas
{
	CGPoint originPoint;
	CGPoint endOriginPoint;

	CGFloat floorY;
	CGFloat ceilY;
}


- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor clearColor];

		originPoint = CGPointMake(10, 350);
		endOriginPoint = CGPointMake(originPoint.x + 300, originPoint.y);

		floorY = originPoint.y + 300;
		ceilY = originPoint.y - 300;


		CGFloat size = 10;


		_startPointView = [[MoveCircleView alloc]initWithFrame:CGRectMake(0, 0, size, size)];
		_startPointView.delegate = self;
		_startPointView.center = originPoint;
		[self addSubview:_startPointView];


		_endPointView = [[MoveCircleView alloc]initWithFrame:CGRectMake(0, 0, size, size)];
		_endPointView.delegate = self;
		_endPointView.center = endOriginPoint;
		[self addSubview:_endPointView];


		_controlPointView1 = [[MoveCircleView alloc]initWithFrame:CGRectMake(0, 0, size, size)];
		_controlPointView1.delegate = self;
		_controlPointView1.bgColor = [UIColor greenColor];
		_controlPointView1.center = CGPointMake(originPoint.x + 0.5 * (endOriginPoint.x - originPoint.x), ceilY);
		[self addSubview:_controlPointView1];

		_controlPointView2 = [[MoveCircleView alloc]initWithFrame:CGRectMake(0, 0, size, size)];
		_controlPointView2.delegate = self;
		_controlPointView2.bgColor = [UIColor greenColor];
		_controlPointView2.center = CGPointMake(originPoint.x + 0.5 * (endOriginPoint.x - originPoint.x), floorY);
		[self addSubview:_controlPointView2];
	}
	return self;
}

- (void)touchesMoved:(UIView *)touch {
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	CGFloat w = self.bounds.size.width;
	CGFloat h = self.bounds.size.height;

	//背景
	UIBezierPath *bgPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, w, h)];
	[[UIColor whiteColor]setFill];
	[bgPath fill];

	CGFloat axisWidth = 0.5;

	//Y轴
	[self drawLineWithStartPoint:CGPointMake(originPoint.x, 0) andEndPoint:CGPointMake(originPoint.x, h) andColor:[UIColor blackColor] andLineWidth:axisWidth];
	[self drawLineWithStartPoint:CGPointMake(originPoint.x + 0.5 * (endOriginPoint.x - originPoint.x), 0) andEndPoint:CGPointMake(originPoint.x + 0.5 * (endOriginPoint.x - originPoint.x), h) andColor:[UIColor blackColor] andLineWidth:axisWidth];
	[self drawLineWithStartPoint:CGPointMake(endOriginPoint.x, 0) andEndPoint:CGPointMake(endOriginPoint.x, h) andColor:[UIColor blackColor] andLineWidth:axisWidth];

	//X轴
	[self drawLineWithStartPoint:CGPointMake(0, originPoint.y) andEndPoint:CGPointMake(w, originPoint.y) andColor:[UIColor blackColor] andLineWidth:axisWidth];

	//floorAxisPath轴
	[self drawLineWithStartPoint:CGPointMake(0, floorY) andEndPoint:CGPointMake(w, floorY) andColor:[UIColor blackColor] andLineWidth:axisWidth];

	//ceilAxisPath轴
	[self drawLineWithStartPoint:CGPointMake(0, ceilY) andEndPoint:CGPointMake(w, ceilY) andColor:[UIColor blackColor] andLineWidth:axisWidth];


	///////////
	[self drawLineWithStartPoint:_startPointView.center andEndPoint:_controlPointView1.center andColor:[UIColor blackColor] andLineWidth:axisWidth];
	[self drawLineWithStartPoint:_controlPointView2.center andEndPoint:_endPointView.center andColor:[UIColor blackColor] andLineWidth:axisWidth];




	UIBezierPath *bezierPath = [UIBezierPath bezierPath];
	[bezierPath moveToPoint:_startPointView.center];
	[bezierPath addCurveToPoint:_endPointView.center controlPoint1:_controlPointView1.center controlPoint2:_controlPointView2.center];

	[[UIColor blueColor]setStroke];
	[bezierPath stroke];


	NSLog(@"originPoint:{%.2f,%.2f}  endOriginPoint:{%.2f,%.2f}  controlPoint1:{%.2f,%.2f}  controlPoint2:{%.2f,%.2f}", originPoint.x, originPoint.y, endOriginPoint.x, endOriginPoint.y, _controlPointView1.center.x, _controlPointView1.center.y, _controlPointView2.center.x, _controlPointView2.center.y);
}

- (void)drawLineWithStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint andColor:(UIColor *)lineColor andLineWidth:(CGFloat)lineWidth {
	UIBezierPath *linePath = [UIBezierPath bezierPath];
	[linePath moveToPoint:startPoint];
	[linePath addLineToPoint:endPoint];
	linePath.lineWidth = lineWidth;
	[lineColor setStroke];
	[linePath stroke];
}

@end
