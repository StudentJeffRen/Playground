//
//  RJSimpleFactory.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/15.
//

#import "RJSimpleFactory.h"
#import "RJOperationMantou.h"

@implementation RJSimpleFactory

+ (RJOperation *)operationBreakfast:(SFFactoryProductType)breakfastType {
    RJOperation *operation;
    switch (breakfastType) {
        case SFFactoryProductTypeMantou:
            operation = [[RJOperationMantou alloc] init];
            break;
            
        default:
            return nil;
            break;
    }
    
    return operation;
}

@end
