//
//  RJTableView.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/10/4.
//  

#import "RJTableView.h"
#import "RJScrollViewCell.h"
#import <Aspects.h>

@interface RJTableView ()

@property (nonatomic, strong) NSMutableSet *reuseCells;
@property (nonatomic, strong) Class cellClass;

@end

@implementation RJTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/*
 1. 修改 view 大小
 2. 新增 subview
 ⭐️3. ScrollView 滚动
 4. 旋转设备
 5. 更新约束
 在这次 RunLoop 周期结束之前触发
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    [self refreshView];
}

- (void)refreshView {
    // contentView 大小，即显示内容的区域大小
    self.contentSize = CGSizeMake(self.bounds.size.width, [self.dataSource numberOfRows] * [self getRowHeight]);
    
    // contentOffset 是以 scrollView 左上角为原点，当前滚动到的位置
    for (UIView *cell in [self cellSubViews]) {
        // 顶部滑出的 cell
        if (cell.frame.origin.y + cell.frame.size.height < self.contentOffset.y) {
            [self recycleCell:cell];
        }
        
        // 底部还没有出现的 cell
        if (cell.frame.origin.y > self.contentOffset.y + self.frame.size.height) {
            [self recycleCell:cell];
        }
    }
    
    // 当前屏幕上起始和终止 cell 的索引
    int firstVisibleIndex = MAX(0, floor(self.contentOffset.y / [self getRowHeight]));
    int lastVisibleIndex = MIN([self.dataSource numberOfRows], firstVisibleIndex + 1 + ceil(self.frame.size.height / [self getRowHeight]));
    
    // 添加每一个 cell
    for (int row = firstVisibleIndex; row < lastVisibleIndex; row++) {
        UIView *cell = [self cellForRow:row];
        
        if (!cell) {
            UIView *cell = [self.dataSource cellForRow:row];
            // y 位置不同
            cell.frame = CGRectMake(0, row * [self getRowHeight], self.frame.size.width, [self getRowHeight]);
            [self insertSubview:cell atIndex:0];
        }
    }
}

/// 所有 cell 的数组
- (NSArray *)cellSubViews {
    NSMutableArray *cells = [[NSMutableArray alloc] init];
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[RJScrollViewCell class]]) {
            [cells addObject:subView];
        }
    }
    return [cells copy];
}

/// 添加到复用池，并从视图中移除
- (void)recycleCell:(UIView *)cell {
    [self.reuseCells addObject:cell];
    [cell removeFromSuperview];
}

- (UIView *)cellForRow:(NSInteger)row {
    float topForRow = row * [self getRowHeight];
    for (UIView *cell in [self cellSubViews]) {
        if (cell.frame.origin.y == topForRow) {
            return cell;
        }
    }
    return nil;
}

- (CGFloat)getRowHeight {
    CGFloat rowHeight = 50.0f;
    @try {
        if ([self.dataSource rowHeight]) {
            rowHeight = [self.dataSource rowHeight];
        }
    } @catch (NSException *exception) {
        rowHeight = 50.0f;
    } @finally {
        
    }
    return rowHeight;
}

#pragma mark - 复用 Public Method
- (void)registerClassForCells:(Class)cellClass {
    self.cellClass = cellClass;
}

- (UIView *)dequeueReusableCell {
    UIView *cell = [self.reuseCells anyObject];
    if (cell) {
        // 从复用池中取到的 cell
        [self.reuseCells removeObject:cell];
    } else {
        // 新创建的 cell
        cell = [[self.cellClass alloc] init];
    }
    return cell;
}

#pragma mark - Setter
- (void)setDataSource:(id<RJTableViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self refreshView];
}

- (NSMutableSet *)reuseCells {
    if (!_reuseCells) {
        _reuseCells = [[NSMutableSet alloc] init];
        [_reuseCells aspect_hookSelector:@selector(addObject:) withOptions:AspectPositionAfter usingBlock:^{
            NSLog(@"复用池中有 %ld 个 cell", self->_reuseCells.count);
        } error:nil];
    }
    return _reuseCells;
}

@end
