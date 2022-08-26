//
//  RJSimpleFactory.h
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/15.
//

#import <Foundation/Foundation.h>
#import "RJOperation.h"

typedef NS_ENUM(NSInteger, SFFactoryProductType) {
    SFFactoryProductTypeMantou,
    SFFactoryProductTypeYoutiao,
};

NS_ASSUME_NONNULL_BEGIN

@interface RJSimpleFactory : NSObject

+ (RJOperation *)operationBreakfast:(SFFactoryProductType)breakfastType;

@end

NS_ASSUME_NONNULL_END
