//
//  RJAPIManager.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/16.
//

#import "RJAPIManager.h"

@interface RJAPIManager ()

@property (nonatomic, strong) NSDictionary *rawData;

@end

@implementation RJAPIManager
- (NSDictionary *)fetchDataWithReformer:(id<RJReformerProtocol>)reformer {
    if (reformer == nil) {
        return self.rawData;
    } else {
        return [reformer reformDataWithManager:self];
    }
}
@end
