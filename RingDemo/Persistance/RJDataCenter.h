//
//  RJDataCenter.h
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJDataCenter : NSObject

- (NSArray *)fetchItemListWithFilter:(NSDictionary *)filter;

@end

NS_ASSUME_NONNULL_END
