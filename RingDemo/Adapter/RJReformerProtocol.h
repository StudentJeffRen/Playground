//
//  RJReformerProtocol.h
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class RJAPIManager;
@protocol RJReformerProtocol <NSObject>

- (NSDictionary *)reformDataWithManager:(RJAPIManager *)manager;

@end

NS_ASSUME_NONNULL_END
