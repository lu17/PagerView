//
//  UIView+Private.h
//  BlockExample
//
//  Created by hcc on 15/7/15.
//  Copyright (c) 2015年 pupuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Private)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

@end
