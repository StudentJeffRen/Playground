//
//  RJOperation.h
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/15.
//  抽象产品

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJOperation : NSObject

@property (nonatomic, copy, readonly) NSString *product;
- (void)productBreakfast; 

@end

NS_ASSUME_NONNULL_END
