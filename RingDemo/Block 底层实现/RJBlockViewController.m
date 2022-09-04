//
//  RJBlockViewController.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/28.
//

#import "RJBlockViewController.h"

typedef int(^blk_t)(int);

void (^blk)(void) = ^{
    NSLog(@"在记述全局变量的地方使用 Block 语法，生成的 Block 为 _NSConcreteGlobalBlock 类对象，结构体实例设置在程序的数据区");
};

@interface RJBlockViewController ()

@property (nonatomic, copy) void (^block)(void);

@end

@implementation RJBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 由 __block 修饰的变量会被包装成一个对象
    /*
     struct __Block_byref_obj_0 {
       void *__isa;
     __Block_byref_obj_0 *__forwarding;
      int __flags;
      int __size;
      void (*__Block_byref_id_object_copy)(void*, void*);
      void (*__Block_byref_id_object_dispose)(void*);
      NSObject *__strong obj;
     };
     */
    __block NSObject *obj = [[NSObject alloc] init];
    int age = 20;
    static int count = 1;
    
    /*
     struct __ViewController__viewDidLoad_block_impl_0 {
       struct __block_impl impl;
       struct __ViewController__viewDidLoad_block_desc_0* Desc;
       int *count;
       int age;
       ViewController *const __strong self;
       __Block_byref_obj_0 *obj; // by ref
       __ViewController__viewDidLoad_block_impl_0(void *fp, struct __ViewController__viewDidLoad_block_desc_0 *desc, int *_count, int _age, ViewController *const __strong _self, __Block_byref_obj_0 *_obj, int flags=0) : count(_count), age(_age), self(_self), obj(_obj->__forwarding) {
         impl.isa = &_NSConcreteStackBlock;
         impl.Flags = flags;
         impl.FuncPtr = fp;
         Desc = desc;
       }
     };
     */
    
    void (^localBlock)(void);
    {
        id array = [[NSMutableArray alloc] init];
        // 赋值给 __strong 修饰的自动变量，自动拷贝到堆
        localBlock = ^{
            count = 2;
            NSLog(@"age is %d", age);
            NSLog(@"obj is %@", obj);
            NSLog(@"self is %@", self);
            [array addObject:[[NSObject alloc] init]];
        };
    }
    // array 超出作用域本应该销毁，但堆 block 持有了它
    
    localBlock();
    NSLog(@"%d", count);
    
    
    __block int val = 0;
    // 赋值给 copy 修饰的成员变量，自动拷贝到堆
    __weak typeof(self) weakSelf = self;
    self.block = ^{
        // __forwarding 指针，当 block 被拷贝到堆时，指向堆上的对象，确保不论 __block 变量是在栈上还是在堆上，都能正确地访问
        
        val++;
        // 堆 block 根据捕获的变量的修饰符，判断对外部对象是强引用还是弱引用
        NSLog(@"self is %@", weakSelf);
    };
    
    val++; // 先访问的是栈上的结构体，再通过 __forwarding 找到了堆上的结构体
    self.block();
    
    NSArray *array = [self getBlockArray];
    void (^blkFromArray)(void) = [array objectAtIndex:0];
    blkFromArray();
}

blk_t func(int rate) {
    // block 最为函数返回值，自动复制到堆上
    return ^(int count) {
        return rate * count;
    };
}

// 向方法参数中传递 block 时需要手动复制
// Cocoa 框架带有 usingBlock 的方法和 GCD API 会自动复制
- (id)getBlockArray {
    int val = 10;
    
    return [[NSArray alloc] initWithObjects:
            ^{NSLog(@"blk0:%d", val);},
            ^{NSLog(@"blk1:%d", val);}, nil];
}

@end
