//
//  UIView+RJConvenience.h
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (RJConvenience)

@property (nonatomic) CGFloat rj_left;        /// Shortcut for frame.origin.x.
@property (nonatomic) CGFloat rj_top;         /// Shortcut for frame.origin.y
@property (nonatomic) CGFloat rj_right;       /// Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat rj_bottom;      /// Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat rj_width;       /// Shortcut for frame.size.width.
@property (nonatomic) CGFloat rj_height;      /// Shortcut for frame.size.height.
@property (nonatomic) CGFloat rj_centerX;     /// Shortcut for center.x
@property (nonatomic) CGFloat rj_centerY;     /// Shortcut for center.y

@end

NS_ASSUME_NONNULL_END
