//
//  RJFrameAndBoundsViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/9/1.
//

#import "RJFrameAndBoundsViewController.h"

@interface RJFrameAndBoundsViewController ()

@end

@implementation RJFrameAndBoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     两条基本原则：
     1. Frame is in terms of superview's coordinate system.
     2. Bounds is in terms of local coordinate system.
     修改 bounds 不会影响自己的位置，只是修改了自己坐标系的原点，进而影响到子视图的位置（因为子视图的 frame 参照的就是我的坐标系）。
     */
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view2.backgroundColor = [UIColor yellowColor];
    [view1 addSubview:view2];
    
    // 根据 bounds 的定义，view1 相对自己坐标原点的位置改成了 20, 20
    // view1 并不会移动，反倒是坐标系原点移动到了 -20, -20（左上)
    // 所以导致了 view2 向左上移动
//    [UIView animateWithDuration:3.0 animations:^{
//        view1.bounds = CGRectMake(20, 20, 200, 200);
//    }];
    
    // 改变 bounds 宽高，不会改变 view1 的中心点，相当于缩放效果
    // 因为没改 x, y(坐标系原点)，所以 view2 会始终贴着 view1 移动
    [UIView animateWithDuration:3.0 animations:^{
        view1.bounds = CGRectMake(0, 0, 100, 100);
    }];
}


@end
