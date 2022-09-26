//
//  RJKVOViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/9/23.
//  1. KVO 通知是同步还是异步？同步
//  2. readonly 属性会触发 KVO 吗？直接修改成员变量不会触发 KVO
//  3. 分类中的属性能使用 KVO 吗？

#import "RJKVOViewController.h"
#import "RJKVOViewController+CategoryProperty.h"

@interface RJKVOViewController ()

@end

@implementation RJKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self categoryProperty];
}

- (void)categoryProperty {
    // 分类中的属性
    [self addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    // 分类中的属性不会生成方法实现
    // 只要提供了 set 方法的实现（不论是否使用关联对象），KVO 能正常触发
    self.num = 10;
}

- (void)readOnlyProperty {
    [self addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    _age = 10;
    // 如果是KVO通知同步的，会在这之前打印回调
    NSLog(@"------");
    _age = 20;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"回调触发");
}

@end
