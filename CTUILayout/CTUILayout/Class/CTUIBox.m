//
//  CTUIBox.m
//  CTUILayout
//
//  Created by Chentao on 15/2/3.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "CTUIBox.h"

@implementation CTUIBox

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.gap = 0.0f;
    self.paddingBottom = 0.0f;
    self.paddingLeft = 0.0f;
    self.paddingRight = 0.0f;
    self.paddingTop = 0.0f;
    self.verticalAlign = BoxAlignTypeTop;
    self.horizontalAlign = BoxAlignTypeLeft;
    self.measure = NO;
  }
  return self;
}

- (void)setMeasure:(BOOL)measure {
  if (_measure ^ measure) {
    _measure = measure;
    [self setNeedsLayout];
  }
}

- (void)setGap:(CGFloat)gap {
  if (_gap != gap) {
    _gap = gap;
    [self setNeedsLayout];
  }
}

- (void)setVerticalAlign:(BoxAlignType)verticalAlign {
  if (_verticalAlign != verticalAlign) {
    _verticalAlign = verticalAlign;
    [self setNeedsLayout];
  }
}

- (void)setHorizontalAlign:(BoxAlignType)horizontalAlign {
  if (_horizontalAlign != horizontalAlign) {
    _horizontalAlign = horizontalAlign;
    [self setNeedsLayout];
  }
}

- (void)setPaddingTop:(CGFloat)paddingTop {
  if (_paddingTop != paddingTop) {
    _paddingTop = paddingTop;
    [self setNeedsLayout];
  }
}

- (void)setPaddingBottom:(CGFloat)paddingBottom {
  if (_paddingBottom != paddingBottom) {
    _paddingBottom = paddingBottom;
    [self setNeedsLayout];
  }
}

- (void)setPaddingLeft:(CGFloat)paddingLeft {
  if (_paddingLeft != paddingLeft) {
    _paddingLeft = paddingLeft;
    [self setNeedsLayout];
  }
}

- (void)setPaddingRight:(CGFloat)paddingRight {
  if (_paddingRight != paddingRight) {
    _paddingRight = paddingRight;
    [self setNeedsLayout];
  }
}

- (CGSize)measureBoxSize {
  return CGSizeZero;
}

@end
