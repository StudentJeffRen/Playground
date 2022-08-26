//
//  RJViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/23.
//

#import "RJViewController.h"
#import "RJProxy.h"
#import "RJTimer.h"
@interface RJViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSString *name;

@end

@implementation RJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 自己生成并不持有
    // 根据命名规则不以 alloc/new/copy/mutableCopy 开头
    // 该方法返回对象之前会 release 一次，使得返回的对象引用计数处于平衡状态，从外部调用者角度看就是不持有
    // GNUStep 实现:
    /*
     + (NSTimer*) scheduledTimerWithTimeInterval: (NSTimeInterval)ti
                          target: (id)object
                        selector: (SEL)selector
                        userInfo: (id)info
                         repeats: (BOOL)f
     {
       id t = [[self alloc] initWithFireDate: nil
                        interval: ti
                      target: object
                        selector: selector
                        userInfo: info
                     repeats: f];
       [[NSRunLoop currentRunLoop] addTimer: t forMode: NSDefaultRunLoopMode];
       RELEASE(t);
       return t;
     }
     */
    // 继续看 initWithFireDate 方法，内部确实对 target 进行了强引用
//
    
    self.name = [RJTimer executeTask:^{
        NSLog(@"bbb");
    } start:2.0 interval:1.0 repeat:YES async:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [RJTimer cancelTimer:self.name];
}

- (void)myMethod {
    NSLog(@"aaa");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 如果 invalidate 写在生命周期方法中，进二级页面也会停止计时器
    // 所以写在 dealloc 方法中是有必要的
}

- (void)dealloc {
    // 要确保这个方法能执行
    /*
     移除 RunLoop 对 timer 的强引用
     移除 timer 对 target, user info 的强引用
     */
    [self.timer invalidate];
    NSLog(@"%s", __func__);
}

@end
