//
//  CTUIGroup.m
//  CTUILayout
//
//  Created by Chentao on 15/2/3.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "CTUIGroup.h"

@implementation CTUIGroup

- (void)layoutSubviews {
  [super layoutSubviews];

  int i = 0;
  NSUInteger numChild = self.subviews.count;
  for (i = 0; i < numChild; i++) {
    UIView *child = [self.subviews objectAtIndex:i];
    if (child.includeInLayout) {
      NSNumber *left = child.left;
      NSNumber *right = child.right;
      NSNumber *top = child.top;
      NSNumber *bottom = child.bottom;
      NSNumber *vc = child.verticalCenter;
      NSNumber *hc = child.horizontalCenter;

      NSNumber *pw = child.percentWidth;
      NSNumber *ph = child.percentHeight;

      CGFloat childWidth = 0.0;
      CGFloat childHeight = 0.0;

      if (pw) {
        CGFloat availableWidth = self.bounds.size.width;
        if (left) {
          availableWidth -= [left floatValue];
        }
        if (right) {
          availableWidth -= [right floatValue];
        }

        childWidth = roundf(availableWidth * MIN([pw floatValue] * 0.01, 1.0));
      } else if (left && right) {
        childWidth =
            self.bounds.size.width - [right floatValue] - [left floatValue];
      } else {
        childWidth = child.frame.size.width;
      }

      if (ph) {
        CGFloat availableHeight = self.bounds.size.height;
        if (top) {
          availableHeight -= [top floatValue];
        }
        if (bottom) {
          availableHeight -= [bottom floatValue];
        }

        childHeight =
            roundf(availableHeight * MIN([ph floatValue] * 0.01, 1.0));
      } else if (top && bottom) {
        childHeight =
            self.bounds.size.height - [bottom floatValue] - [top floatValue];
      } else {
        childHeight = child.frame.size.height;
      }

      CGFloat childX = 0.0;
      CGFloat childY = 0.0;

      if (hc) {
        childX = 0.5 * (self.bounds.size.width - childWidth) + [hc floatValue];
      } else if (left) {
        childX = [left floatValue];
      } else if (right) {
        childX = self.bounds.size.width - childWidth - [right floatValue];
      } else {
        childX = child.frame.origin.x;
      }

      if (vc) {
        childY =
            0.5 * (self.bounds.size.height - childHeight) + [vc floatValue];
      } else if (top) {
        childY = [top floatValue];
      } else if (bottom) {
        childY = self.bounds.size.height - childHeight - [bottom floatValue];
      } else {
        childY = child.frame.origin.y;
      }

      child.frame = CGRectMake(childX, childY, childWidth, childHeight);
    } else {
      continue;
    }
  }
}

@end
