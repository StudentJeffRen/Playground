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
#import "RJBlockViewController.h"
#import "RJLoadPerson.h"
#import "RJLoadStudent.h"
#import "RJGCDDemoViewController.h"
#import "RJKVOViewController.h"

@interface ViewController ()

@property (nonatomic, copy) void (^block)(void);

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImageView *imageView = [[UIImageView alloc] init];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:@""]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    RJKVOViewController *vc = [[RJKVOViewController alloc] init];
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

@end
