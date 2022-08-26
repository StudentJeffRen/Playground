//
//  RJTimer.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/25.
//

#import "RJTimer.h"

@implementation RJTimer

// 保存正在运行的定时器，用于中途取消
static NSMutableDictionary *_timers;
// 二元信号量给字典加锁
dispatch_semaphore_t _semaphore;

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _timers = [[NSMutableDictionary alloc] init];
        _semaphore = dispatch_semaphore_create(1);
    });
}

+ (NSString *)executeTask:(void (^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeat:(BOOL)repeat async:(BOOL)async {
    if (!task || start < 0 || (interval <= 0 && repeat)) {
        return nil;
    }
    
    // 队列
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    
    // 创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置定时器
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    // 唯一标识
    NSString *name = [NSString stringWithFormat:@"%zd", _timers.count];
    _timers[name] = timer;
    dispatch_semaphore_signal(_semaphore);
    
    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
        task();
        
        if (!repeat) {
            [self cancelTimer:name];
        }
    });
    
    dispatch_resume(timer);
    
    return name;
}

+ (void)cancelTimer:(NSString *)name {
    if (name.length == 0) {
        return;
    }
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    dispatch_source_t timer = _timers[name];
    if (timer) {
        dispatch_source_cancel(timer);
        [_timers removeObjectForKey:name];
    }
    dispatch_semaphore_signal(_semaphore);
}

@end
