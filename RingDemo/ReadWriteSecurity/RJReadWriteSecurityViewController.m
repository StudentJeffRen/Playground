//
//  RJReadWriteSecurityViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/7/29.
//

#import "RJReadWriteSecurityViewController.h"

@interface RJReadWriteSecurityViewController ()

@end

@implementation RJReadWriteSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)读写安全 {
    // GCD 栅栏
    dispatch_block_t block0_for_reading = ^{};
    dispatch_block_t block1_for_reading = ^{};
    dispatch_block_t block2_for_reading = ^{};
    dispatch_block_t block3_for_reading = ^{};
    dispatch_block_t block_for_writing = ^{};
    
    dispatch_queue_t queue = dispatch_queue_create("cn.jeffren.gcd.Forbarrier", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, block0_for_reading);
    dispatch_async(queue, block1_for_reading);
    // 等待并行队列中的处理全部结束后，再将指定处理追加到并行队列
    dispatch_barrier_async(queue, block_for_writing);
    // 处理执行完毕，恢复
    dispatch_async(queue, block2_for_reading);
    dispatch_async(queue, block3_for_reading);
}

@end
