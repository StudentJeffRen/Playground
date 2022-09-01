//
//  ViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2021/12/24.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import <SDWebImage/SDWebImage.h>
#import "RJPerson.h"
#import "RJViewController.h"
#import "RJDrawerViewController.h"
#import "RJFrameAndBoundsViewController.h"

@interface ViewController ()

@property (nonatomic, copy) void (^block)(void);

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImageView *imageView = [[UIImageView alloc] init];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:@""]];
    
//    RJPerson *person = [[RJPerson alloc] init];
//    [person hello];
    
//    [self gcdSerialDemo];
//    [self gcdConcurrentDemo];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    RJFrameAndBoundsViewController *vc = [[RJFrameAndBoundsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)hello {
    NSLog(@"hi");
}

- (void)useURLSession {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://news-at.zhihu.com/api/4/news/latest"]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", dataString);
    }];
    [task resume];
}

- (void)useAFNetworking {
    // AFNetworking 最外层 API，发起请求，设置回调
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://news-at.zhihu.com"]];
    [manager GET:@"api/4/news/latest" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@" ,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

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

@end
