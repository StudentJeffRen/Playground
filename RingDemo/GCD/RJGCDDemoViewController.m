//
//  RJGCDDemoViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/9/5.
//

#import "RJGCDDemoViewController.h"

@interface RJGCDDemoViewController ()

@end

@implementation RJGCDDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self gcdSerialDemo];
//    [self gcdConcurrentDemo];
//    [self dispatchGroup];
    
    NSLog(@"1---%@",[NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    // 同步任务，在和上下文相同的线程执行
    // 异步任务，在另一个线程执行
    dispatch_async(queue, ^{
        NSLog(@"2---%@",[NSThread currentThread]);
        dispatch_async(queue, ^{
            NSLog(@"3---%@",[NSThread currentThread]);
        });
        NSLog(@"4---%@",[NSThread currentThread]);
    });
    
    NSLog(@"5---%@",[NSThread currentThread]);
}

/* 串行
 2022-09-05 15:53:48.317663+0800 RingDemo[83792:19657189] 1---<_NSMainThread: 0x600003bd0100>{number = 1, name = main}
 2022-09-05 15:53:48.317813+0800 RingDemo[83792:19657189] 5---<_NSMainThread: 0x600003bd0100>{number = 1, name = main}
 2022-09-05 15:53:48.317886+0800 RingDemo[83792:19657311] 2---<NSThread: 0x600003b43700>{number = 8, name = (null)}
 2022-09-05 15:53:48.318017+0800 RingDemo[83792:19657311] 4---<NSThread: 0x600003b43700>{number = 8, name = (null)}
 2022-09-05 15:53:48.318144+0800 RingDemo[83792:19657311] 3---<NSThread: 0x600003b43700>{number = 8, name = (null)}
 */

/* 并发
 2022-09-05 15:55:59.455113+0800 RingDemo[83873:19659240] 1---<_NSMainThread: 0x6000015940c0>{number = 1, name = main}
 2022-09-05 15:55:59.455272+0800 RingDemo[83873:19659240] 5---<_NSMainThread: 0x6000015940c0>{number = 1, name = main}
 2022-09-05 15:55:59.455314+0800 RingDemo[83873:19659374] 2---<NSThread: 0x6000015f0400>{number = 7, name = (null)}
 2022-09-05 15:55:59.455490+0800 RingDemo[83873:19659374] 4---<NSThread: 0x6000015f0400>{number = 7, name = (null)}
 2022-09-05 15:55:59.455509+0800 RingDemo[83873:19659369] 3---<NSThread: 0x6000015f9880>{number = 8, name = (null)}
 */

- (void)gcdSerialDemo {
    dispatch_queue_t serialQueue = dispatch_queue_create("cn.jeffren.serial", DISPATCH_QUEUE_SERIAL);
    
    // 当前线程：主线程
    
    // 对于同步任务，添加到串行队列，通常在和上下文相同的线程执行
    dispatch_sync(serialQueue, ^{
        // 任务加入自定义串行队列（不是主队列），所以不会产生死锁
        sleep(3);
        NSLog(@"task 1 %@", NSThread.currentThread);
    });
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"task 2 %@", NSThread.currentThread);
    });
    
    // 异步任务，添加到串行队列，通常在另一个线程执行
    dispatch_async(serialQueue, ^{
        NSLog(@"task 3 %@", NSThread.currentThread);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"task 4 %@", NSThread.currentThread);
    });
    
    NSLog(@"test end %@", NSThread.currentThread);
}

- (void)gcdConcurrentDemo {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("cn.jeffren.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    // 当前线程：主线程
    
    // 对于同步任务，通常在和上下文相同的线程执行
    dispatch_sync(concurrentQueue, ^{
        sleep(3);
        NSLog(@"task 1 %@", NSThread.currentThread);
    });
    
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"task 2 %@", NSThread.currentThread);
    });
    
    // 异步任务，添加到并行队列，通常在另一个线程执行，顺序不确定
    dispatch_async(concurrentQueue, ^{
        NSLog(@"task 3 %@", NSThread.currentThread);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"task 4 %@", NSThread.currentThread);
    });
    
    NSLog(@"test end %@", NSThread.currentThread);
}

- (void)dispatchGroup {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"A");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"B");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"C");
    });
}

// 使用场景：读写安全
- (void)dispatchBarrier {
    dispatch_queue_t queue = dispatch_queue_create("rw_queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        
    });
    
    dispatch_barrier_async(queue, ^{
        // 在前面提交到队列中的任务执行完之前，栅栏 block 不会执行
    });
}

@end
