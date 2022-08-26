//
//  NSObject+RJUnrecognizedSelector.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/8.
//

#import "NSObject+RJUnrecognizedSelector.h"
#import <objc/runtime.h>

@implementation NSObject (RJUnrecognizedSelector)

+ (void)load {
    Method originalMethod1 = class_getInstanceMethod([self class], @selector(methodSignatureForSelector:));
    Method swizzlingMethod1 = class_getInstanceMethod([self class], @selector(rj_methodSignatureForSelector:));
    method_exchangeImplementations(originalMethod1, swizzlingMethod1);
    
    Method originalMethod2 = class_getInstanceMethod([self class], @selector(forwardInvocation:));
    Method swizzlingMethod2 = class_getInstanceMethod([self class], @selector(rj_forwardInvocation:));
    method_exchangeImplementations(originalMethod2, swizzlingMethod2);
}

- (NSMethodSignature *)rj_methodSignatureForSelector:(SEL)aSelector{
//    if (![self respondsToSelector:aSelector]) {
//        NSMethodSignature *methodSignature = [self rj_methodSignatureForSelector:aSelector];
//        class_addMethod([self class], aSelector, (IMP)dynamicMethodIMP, "v@:");
//
//        if (!methodSignature) {
//            methodSignature = [self rj_methodSignatureForSelector:aSelector];
//        }
//
//        return methodSignature;
//    } else {
//        return [self rj_methodSignatureForSelector:aSelector];
//    }
    
    if (![self respondsToSelector:aSelector]) {
        // 为找不到的方法动态添加实现
        class_addMethod([self class], aSelector, (IMP)dynamicMethodIMP, "v@:");
    }
    
    return [self rj_methodSignatureForSelector:aSelector];
}

- (void)rj_forwardInvocation:(NSInvocation *)anInvocation{
    SEL selector = [anInvocation selector];
    if ([self respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:self];
    } else {
        [self rj_forwardInvocation:anInvocation];
    }
}

void dynamicMethodIMP(id self, SEL _cmd) {
#ifdef DEBUG
    NSLog(@"找不到方法实现");
#else
    // 上传错误
#endif
}

@end
