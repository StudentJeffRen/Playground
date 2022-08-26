//
//  RJProxy.h
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJProxy : NSProxy

+ (instancetype)weakProxyForObject:(id)targetObject;

@end

NS_ASSUME_NONNULL_END
