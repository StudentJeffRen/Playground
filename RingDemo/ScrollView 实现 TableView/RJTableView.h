//
//  RJTableView.h
//  RingDemo
//
//  Created by 任睿杰 on 2022/10/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RJTableViewDataSource <NSObject>

- (NSInteger)numberOfRows;
- (CGFloat)rowHeight;
- (UIView *)cellForRow:(NSInteger)row;

@end

@interface RJTableView : UIScrollView

@property (nonatomic, weak) id <RJTableViewDataSource> dataSource;

- (UIView *)dequeueReusableCell;
- (void)registerClassForCells:(Class)cellClass;

@end

NS_ASSUME_NONNULL_END
