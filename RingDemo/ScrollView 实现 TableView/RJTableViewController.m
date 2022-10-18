//
//  RJTableViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/10/4.
//

#import "RJTableViewController.h"
#import "RJTableView.h"
#import "RJScrollViewCell.h"

@interface RJTableViewController () <RJTableViewDataSource>

@property (nonatomic, strong) RJTableView *tableView;

@end

@implementation RJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[RJTableView alloc] initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    [self.tableView registerClassForCells:[RJScrollViewCell class]];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfRows {
    return 30;
}

- (UIView *)cellForRow:(NSInteger)row {
    RJScrollViewCell *cell = (RJScrollViewCell *)[self.tableView dequeueReusableCell];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld行", row];
    return cell;
}

- (CGFloat)rowHeight {
    return 100;
}

@end
