//
//  MainView.m
//  CTUILayout
//
//  Created by Chentao on 15/2/3.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		//偏左30 ，偏下30
		UIView *topLeftView =
		    [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40.0, 40.0)];
		topLeftView.backgroundColor = [UIColor redColor];
		topLeftView.includeInLayout = YES;
		topLeftView.left = [NSNumber numberWithFloat:30.0f];
		topLeftView.top = [NSNumber numberWithFloat:30.0f];
		[self addSubview:topLeftView];


		//偏右30 ，偏下30
		UIView *topRightView =
		    [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40.0, 40.0)];
		topRightView.backgroundColor = [UIColor greenColor];
		topRightView.includeInLayout = YES;
		topRightView.right = [NSNumber numberWithFloat:30.0f];
		topRightView.top = [NSNumber numberWithFloat:30.0f];
		[self addSubview:topRightView];



		//偏左30 ，偏上30
		UIView *bottomLeftView =
		    [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40.0, 40.0)];
		bottomLeftView.backgroundColor = [UIColor blueColor];
		bottomLeftView.includeInLayout = YES;
		bottomLeftView.left = [NSNumber numberWithFloat:30.0f];
		bottomLeftView.bottom = [NSNumber numberWithFloat:30.0f];
		[self addSubview:bottomLeftView];


		//偏右30 ，偏上30
		UIView *bottomRightView =
		    [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40.0, 40.0)];
		bottomRightView.backgroundColor = [UIColor blackColor];
		bottomRightView.includeInLayout = YES;
		bottomRightView.right = [NSNumber numberWithFloat:30.0f];
		bottomRightView.bottom = [NSNumber numberWithFloat:30.0f];
		[self addSubview:bottomRightView];


		//水平居中 ，垂直居中
		UIView *centerView =
		    [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40.0, 40.0)];
		centerView.backgroundColor = [UIColor purpleColor];
		centerView.includeInLayout = YES;
		centerView.verticalCenter = [NSNumber numberWithFloat:0.0f];
		centerView.horizontalCenter = [NSNumber numberWithFloat:0.0f];
		[self addSubview:centerView];



		//水平居中 ，偏上50，宽度占父容器的50%
		UIView *otherView =
		    [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40.0, 40.0)];
		otherView.backgroundColor = [UIColor grayColor];
		otherView.includeInLayout = YES;
		otherView.bottom = [NSNumber numberWithFloat:50.0f];
		otherView.percentWidth = [NSNumber numberWithFloat:50.0f];
		otherView.horizontalCenter = [NSNumber numberWithFloat:0.0f];
		[self addSubview:otherView];
	}
	return self;
}

@end
