//
//  RJEnlargeButtonViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/10/27.
//

#import "RJEnlargeButtonViewController.h"

@interface RJEnlargeButtonViewController ()

@end

@implementation RJEnlargeButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(200, 300, 40, 40);
    [button1 addTarget:self action:@selector(hello) forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor = [UIColor redColor];
    [self.view addSubview:button1];
}

- (void)hello {
    NSLog(@"hi");
}

@end
