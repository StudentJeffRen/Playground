//
//  RJPersistanceViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/17.
//

#import "RJPersistanceViewController.h"
#import "RJDataCenter.h"

@interface RJPersistanceViewController ()

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) RJDataCenter *dataCenter;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RJPersistanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 数据源
    self.dataList = [NSMutableArray array];
    
}

- (void)filter {
    // 用户产生的筛选条件
    NSDictionary *filter = @{
        @"key1":@{
            @"minValue1":@(1),
            @"maxValue1":@(9),
        },
        @"key2":@{
            @"minValue2":@(1),
            @"maxValue2":@(9),
        },
        @"key3":@{
            @"minValue3":@(1),
            @"maxValue3":@(9),
        },
    };
    // 交给 dataCenter
    NSArray *fetchedRecordList = [self.dataCenter fetchItemListWithFilter:filter];
    [self.dataList addObjectsFromArray:fetchedRecordList];
    [self.tableView reloadData];
}

- (RJDataCenter *)dataCenter {
    if (!_dataCenter) {
        _dataCenter = [[RJDataCenter alloc] init];
    }
    return _dataCenter;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

@end
