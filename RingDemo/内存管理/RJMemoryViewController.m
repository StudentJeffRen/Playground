//
//  RJMemoryViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/25.
//

#import "RJMemoryViewController.h"
#import "RJTest.h"

@interface RJMemoryViewController ()

@end

@implementation RJMemoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)referenceCircle {
    RJTest *test0 = [[RJTest alloc] init];
    // test0 持有对象 A
    RJTest *test1 = [[RJTest alloc] init];
    // test1 持有对象 B
    test0.obj = test1;
    // 对象 A 成员变量 obj 持有对象 B
    test1.obj = test0;
    // 对象 B 成员变量 obj 持有对象 A
}
// test0 超出作用域，不再持有对象 A
// test1 超出作用域，不再持有对象 B
// 但对象 A 仍然被对象 B 的成员变量 obj 持有
// 但对象 B 仍然被对象 A 的成员变量 obj 持有
// 内存泄漏

- (void)selfReference {
    // 自引用
    RJTest *test = [[RJTest alloc] init];
    test.obj = test;
}

- (void)weakReference {
    RJTest *obj0 = [[RJTest alloc] init];
    RJTest __weak *obj1 = obj0;
}

@end
