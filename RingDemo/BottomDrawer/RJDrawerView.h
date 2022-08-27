//
//  RJDrawerView.h
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RJDrawerSwipeBlock)(void);

@interface RJDrawerView : UIView

@property (nonatomic, copy) RJDrawerSwipeBlock expandBlock;
@property (nonatomic, copy) RJDrawerSwipeBlock foldBlock;

- (instancetype)initWithFrame:(CGRect)frame originHeight:(CGFloat)originHeight spaceToTop:(CGFloat)spaceToTop;
- (void)addContentView:(__kindof UIView *)view;

@end

NS_ASSUME_NONNULL_END
