//
//  RJAPIManager.h
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import "RJReformerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class RJAPIManager;
@protocol RJAPIManagerProtocol <NSObject>

- (void)apiManagerDidSuccess:(RJAPIManager *)manager;

@end

@interface RJAPIManager : NSObject

@property (nonatomic, weak) id<RJAPIManagerProtocol> delegate;

- (NSDictionary *)fetchDataWithReformer:(nullable id<RJReformerProtocol>)reformer;

@end

NS_ASSUME_NONNULL_END
