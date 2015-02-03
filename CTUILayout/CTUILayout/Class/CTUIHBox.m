//
//  CTUIHBox.m
//  CTUILayout
//
//  Created by Chentao on 15/2/3.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "CTUIHBox.h"

@implementation CTUIHBox
- (void)layoutSubviews {
  [super layoutSubviews];
  if (self.measure) {
    CGSize measureSize = [self measureSize];

    BOOL resize = NO;
    if (measureSize.width != self.bounds.size.width ||
        measureSize.height != self.bounds.size.height) {
      resize = YES;
    }

    CGRect newFrame = self.frame;
    newFrame.size.width = measureSize.width;
    newFrame.size.height = measureSize.height;
    self.frame = newFrame;
    [self layoutChildWithSize:measureSize];

    if (resize) {
      if (self.boxDelegate &&
          [self.boxDelegate respondsToSelector:@selector(boxReSize:)]) {
        [self.boxDelegate boxReSize:self];
      }
      if (self.superview) {
        [self.superview setNeedsLayout];
      }
    }
  } else {
    [self layoutChildWithSize:self.bounds.size];
  }
}

- (CGSize)measureBoxSize {
  return [self measureSize];
}

/**
 * 测量大小
 **/
- (CGSize)measureSize {
  CGSize size = CGSizeMake(0.0, 0.0);

  int i = 0;
  NSUInteger numChild = self.subviews.count;

  CGFloat maxH = 0.0;

  CGFloat measureW = self.paddingLeft;
  CGFloat measureH = self.paddingTop;

  for (i = 0; i < numChild; i++) {
    UIView *child = [self.subviews objectAtIndex:i];
    if (maxH < child.frame.size.height) {
      maxH = child.frame.size.height;
    }
    if (child.includeInLayout) {
      measureW += child.frame.size.width;
      if (i < (numChild - 1)) {
        measureW += self.gap;
      }
    }
  }

  measureH += maxH + self.paddingBottom;
  measureW += self.paddingRight;

  size.width = measureW;
  size.height = measureH;
  return size;
}

- (void)layoutChildWithSize:(CGSize)size {
  int i = 0;
  NSUInteger numChild = self.subviews.count;

  CGFloat childX = self.paddingLeft;
  for (i = 0; i < numChild; i++) {
    UIView *child = [self.subviews objectAtIndex:i];
    if (child.includeInLayout) {
      CGFloat childY = 0.0;
      if (BoxAlignTypeTop == self.verticalAlign) {
        childY = self.paddingTop;
      } else if (BoxAlignTypeCenter == self.verticalAlign) {
        childY = 0.5 * (size.height - child.frame.size.height);
      } else if (BoxAlignTypeBottom == self.verticalAlign) {
        childY = size.height - self.paddingBottom - child.frame.size.height;
      }
      child.frame = CGRectMake(childX, childY, child.frame.size.width,
                               child.frame.size.height);
      childX += child.frame.size.width + self.gap;
    }
  }
}
@end
