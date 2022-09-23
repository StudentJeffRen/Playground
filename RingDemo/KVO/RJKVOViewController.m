//
//  RJKVOViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/9/23.
//

#import "RJKVOViewController.h"

@interface RJKVOViewController ()

@property (nonatomic, assign) int age;

@end

@implementation RJKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.age = 10;
    // 如果是KVO通知同步的，会在这之前打印回调
    NSLog(@"------");
    self.age = 20;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"回调触发");
}

@end
