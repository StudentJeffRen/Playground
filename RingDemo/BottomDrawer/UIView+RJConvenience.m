//
//  UIView+RJConvenience.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/27.
//

#import "UIView+RJConvenience.h"

@implementation UIView (RJConvenience)

- (CGFloat)rj_left {
    return self.frame.origin.x;
}

- (void)setRj_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)rj_top {
    return self.frame.origin.y;
}

- (void)setRj_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)rj_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRj_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)rj_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setRj_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)rj_width {
    return self.frame.size.width;
}

- (void)setRj_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)rj_height {
    return self.frame.size.height;
}

- (void)setRj_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)rj_centerX {
    return self.center.x;
}

- (void)setRj_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)rj_centerY {
    return self.center.y;
}

- (void)setRj_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


@end
