//
//  RJDrawerViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/26.
//

#import "RJDrawerViewController.h"
#import "RJDrawerView.h"

@interface RJDrawerViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation RJDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RJDrawerView *drawerView = [[RJDrawerView alloc] initWithFrame:self.view.bounds originHeight:200 spaceToTop:200];
    UITableView *view = [[UITableView alloc] initWithFrame:self.view.bounds];
    view.delegate = self;
    view.dataSource = self;
    view.backgroundColor = [UIColor greenColor];
    [view registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [drawerView addContentView:view];
    [self.view addSubview:drawerView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 33;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

@end
