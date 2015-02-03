//
//  CTUIContainer.h
//  CTUILayout
//
//  Created by Chentao on 15/2/3.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CTUIContainerLayout <NSObject>
- (void)containerLayoutSubviews:(UIView *)container;
@end

/**
 *布局容器的基类
 **/
@interface CTUIContainer : UIView
@property(nonatomic, weak) id<CTUIContainerLayout> containerLayout;
@end
