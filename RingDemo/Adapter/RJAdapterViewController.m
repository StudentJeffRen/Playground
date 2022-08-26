//
//  RJAdapterViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/16.
//

#import "RJAdapterViewController.h"
#import "RJReformerProtocol.h"
#import "RJTableViewCell.h"
#import "RJAPIManager.h"

@interface RJAdapterViewController () <RJAPIManagerProtocol>

@property (nonatomic, strong) id<RJReformerProtocol> reformerA;
@property (nonatomic, strong) id<RJReformerProtocol> reformerB;

@property (nonatomic, strong) RJTableViewCell *viewA;

@end

@implementation RJAdapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RJAPIManager *manager = [[RJAPIManager alloc] init];
    manager.delegate = self;
}

- (void)apiManagerDidSuccess:(RJAPIManager *)manager {
    // 只要是 reformerA 出来的数据，viewA 就可以用
    NSDictionary *reformedData = [manager fetchDataWithReformer:self.reformerA];
    [self.viewA configWithData:reformedData];
}

@end
