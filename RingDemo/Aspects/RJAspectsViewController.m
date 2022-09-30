//
//  RJAspectsViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/9/28.
//

#import "RJAspectsViewController.h"

@interface RJAspectsViewController ()

@end

@implementation RJAspectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 获取方法签名（返回值和参数类型）
    NSMethodSignature *signature = [self methodSignatureForSelector:@selector(test:)];
    // 从方法签名创建 NSInvocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:@selector(test:)];
    NSString *str = @"hello";
    // 0和1位置是给隐藏参数 self 和 _cmd 使用，已经通过
    [invocation setArgument:&str atIndex:2];
    [invocation invoke];
    
    // 手动触发消息转发
    // _objc_msgForward 和 _objc_msgForward_stret
}

- (void)test:(NSString *)string {
    NSLog(@"%@", string);
}

@end
