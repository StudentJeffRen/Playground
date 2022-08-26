//
//  RJTimer.h
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJTimer : NSObject

+ (NSString *)executeTask:(void (^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeat:(BOOL)repeat async:(BOOL)async;

+ (void)cancelTimer:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
