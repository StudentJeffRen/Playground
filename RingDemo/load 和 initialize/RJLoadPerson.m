//
//  RJLoadPerson.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/9/4.
//

#import "RJLoadPerson.h"

@implementation RJLoadPerson
// load 和 initilize 内部都使用了锁，是线程安全的

// Runtime 加载类、分类时调用
// 系统自动调用是直接通过函数地址，不走消息发送机制
// 手动调用是消息发送机制，所以也有可能被调用多次，通常使用 dispatch_once 避免
// 使用场景：方法交换
+ (void)load {
    NSLog(@"%s", __func__);
}

// 类第一次收到消息时调用
// 符合消息发送机制的特性
// 1. 子类没有实现，会找到父类的调用，所以父类的 initialize 方法可能会调用多次
// 2. 分类实现会覆盖类的实现
+ (void)initialize {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
