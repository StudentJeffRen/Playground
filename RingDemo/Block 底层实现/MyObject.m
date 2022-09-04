//
//  MyObject.m
//  BlockDemo
//
//  Created by 任睿杰 on 2022/8/28.
//  __block 修饰符解决循环引用
// MRC 环境下，当 Block 从栈复制到堆时，Block 使用 __block 修饰的自动变量不会被 retain
// ARC 环境下，是将 __block 修饰的自动变量对 self 的强引用解除，来实现破除循环引用（如本例所示）
// 二者原理区别较大

#import "MyObject.h"

typedef void(^blk_t)(void);

@interface MyObject () {
    blk_t blk_;
}
@end

@implementation MyObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        __block id tmp = self;
        
        blk_ = ^{
            NSLog(@"self = %@", tmp);
            tmp = nil;
        };
    }
    return self;
}

- (void)execBlock {
    blk_();
}

-(void)dealloc {
    NSLog(@"%s", __func__);
}

@end
