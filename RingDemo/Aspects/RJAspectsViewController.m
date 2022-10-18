//
//  RJAspectsViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/9/28.
//

#import "RJAspectsViewController.h"
#import <Aspects.h>

@interface RJAspectsViewController ()

@end

@implementation RJAspectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hookInstance];
    [self hookClass];
}

- (void)hookInstance {
    [self aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionBefore usingBlock:^{
        NSLog(@"Instance Hello1");
    } error:nil];
    
    [self aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionBefore usingBlock:^{
        NSLog(@"Instance Hello2");
    } error:nil];
    // 现在，实例对象 self 的 viewWillAppear 方法的 before 容器中，有两个 hook 信息
    
    [self aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionBefore usingBlock:^{
        NSLog(@"Instance Hello3");
    } error:nil];
    // 现在，实例对象 self 的 viewDidAppear 方法的 before 容器中，有一个 hook 信息
}

- (void)hookClass {
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionBefore usingBlock:^{
        NSLog(@"Class Hello Before");
    } error:nil];
    
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionAfter usingBlock:^{
        NSLog(@"Class Hello After");
    } error:nil];
    
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionBefore usingBlock:^{
        NSLog(@"Class Hello Before Duplicate");
    } error:nil];
    
    // 不生效并且报错: viewDidAppear: already hooked in UIViewController. A method can only be hooked once per class hierarchy.
    [RJAspectsViewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionBefore usingBlock:^{
        NSLog(@"Class Hello Before Subclass Duplicate");
    } error:nil];
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
