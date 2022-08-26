//
//  RJProxy.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/25.
//

#import "RJProxy.h"

@interface RJProxy ()

@property (nonatomic, weak) id target;

@end

@implementation RJProxy

+ (instancetype)weakProxyForObject:(id)targetObject
{
    RJProxy *weakProxy = [RJProxy alloc];
    weakProxy.target = targetObject;
    return weakProxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
