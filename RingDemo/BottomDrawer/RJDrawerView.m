//
//  RJDrawerView.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/26.
//

#import "RJDrawerView.h"

static CGFloat const kSwipeThreshold = -150;

@interface RJDrawerView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *gestureView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) __kindof UIView *contentView; // 显示内容
@property (nonatomic, assign) CGFloat offSetBottom; // 最低位置
@property (nonatomic, assign) CGFloat offSetTop; // 最高位置
@property (nonatomic, assign, readonly) BOOL isExpanded;

@end

@implementation RJDrawerView

- (instancetype)initWithFrame:(CGRect)frame originHeight:(CGFloat)originHeight spaceToTop:(CGFloat)spaceToTop
{
    self = [super initWithFrame:frame];
    if (self) {
        self.offSetTop = spaceToTop;
        self.offSetBottom = frame.size.height - originHeight;
        
        [self addSubview:self.backgroundView];
        [self addSubview:self.gestureView];
    }
    return self;
}

- (void)addContentView:(__kindof UIView *)view {
    [self.gestureView addSubview:view];
    self.contentView = view;
}

#pragma mark - Event Response
- (void)panGesture:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.gestureView];
    [recognizer setTranslation:CGPointZero inView:self.gestureView];

    // 到达最底部和最顶部
    CGFloat positionY = self.gestureView.rj_top + translation.y;
    if (positionY >= self.offSetBottom || positionY <= self.offSetTop) {
        return;
    }

    self.gestureView.transform = CGAffineTransformTranslate(self.gestureView.transform, 0, translation.y);
    self.backgroundView.alpha = 1 - (self.gestureView.rj_top - self.offSetTop) / (self.offSetBottom - self.offSetTop);

    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.gestureView];

        if (velocity.y < kSwipeThreshold) {
            // 向上轻扫
            [self expand];
        } else if (velocity.y > -kSwipeThreshold) {
            // 向下轻扫
            [self fold];
        } else {
            // 跟随手指，根据松开时位置，自动回弹
            CGFloat half = (self.offSetBottom - self.offSetTop) / 2;
            if (self.gestureView.rj_top > (half + self.offSetTop)) {
                [self fold];
            } else {
                [self expand];
            }
        }
    }
}

- (void)expand {
    [self animateIsExpandAction:YES];
    
    if (self.expandBlock) {
        self.expandBlock();
    }
}

- (void)fold {
    [self animateIsExpandAction:NO];
    
    if (self.foldBlock) {
        self.foldBlock();
    }
}

- (void)animateIsExpandAction:(BOOL)isExpand {
    if ([self.contentView isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)self.contentView setScrollEnabled:isExpand];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.gestureView.rj_top = isExpand ? self.offSetTop : self.offSetBottom;;
        self.backgroundView.alpha = isExpand ? 1 : 0;
    }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // gestureRecognizer: panGesture
    // otherGestureRecogonizer: tableView scroll
    // 返回值：是否将 tableView 滚动手势置为失败
    if ([self.contentView isKindOfClass:[UIScrollView class]]) {
        if (((UIScrollView *)self.contentView).contentOffset.y > 0) {
            return YES;
        }
    }

    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([self.contentView isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.contentView;
        UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)gestureRecognizer;
        CGFloat direction = [gesture velocityInView:self.gestureView].y;
        
        if ((self.isExpanded && scrollView.contentOffset.y == 0 && direction > 0) || self.gestureView.rj_top == self.offSetBottom) {
            scrollView.scrollEnabled = NO;
        } else {
            scrollView.scrollEnabled = YES;
        }
    }
    
    return NO;
}

#pragma mark - Getter
- (UIView *)gestureView {
    if (!_gestureView) {
        _gestureView = [[UIView alloc] init];
        _gestureView.frame = CGRectMake(0, self.offSetBottom, self.rj_width, self.rj_height);

        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        gesture.delegate = self;
        [_gestureView addGestureRecognizer:gesture];
    }
    return _gestureView;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.alpha = 0;
        _backgroundView.backgroundColor = UIColorFromHexWithAlpha(0x131415, 0.3);
        
        UITapGestureRecognizer *tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fold)];
        [_backgroundView addGestureRecognizer:tapBackground];
    }
    return _backgroundView;
}

- (BOOL)isExpanded {
    return self.gestureView.rj_top == self.offSetTop;
}

@end
