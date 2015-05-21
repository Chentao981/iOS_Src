//
//  ViewController.m
//  BlurView
//
//  Created by Chentao on 15/5/21.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "ViewController.h"
#import "BlurView.h"
#import "DRNRealTimeBlurView.h"
@interface ViewController () <UIScrollViewDelegate>

@end

@implementation ViewController
{
	DRNRealTimeBlurView *bv;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 300, 500)];
	sv.delegate = self;
	UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"test.jpg"]];
	[imageView sizeToFit];
	[sv addSubview:imageView];
	[self.view addSubview:sv];

	sv.contentSize = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height);


	bv = [[DRNRealTimeBlurView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
	bv.tint = [UIColor grayColor];
	[self.view addSubview:bv];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/////////////
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//	[bv setNeedsDisplay];
//}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
	NSLog(@"%s", __FUNCTION__);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	NSLog(@"%s", __FUNCTION__);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
	NSLog(@"%s", __FUNCTION__);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	NSLog(@"%s", __FUNCTION__);
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
	NSLog(@"%s", __FUNCTION__);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	NSLog(@"%s", __FUNCTION__);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	NSLog(@"%s", __FUNCTION__);
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
	NSLog(@"%s", __FUNCTION__);
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
	NSLog(@"%s", __FUNCTION__);
}

@end
