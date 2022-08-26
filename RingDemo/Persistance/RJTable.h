//
//  RJTable.h
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJTable : NSObject

@property (nonatomic, strong) Class recordClass;

- (NSArray *)findAllWithWhereCondition:(NSString *)whereCondition conditionParams:(NSString *)whereConditionParams isDistinct:(BOOL)isDistinct error:(nullable NSError *)error;

@end

NS_ASSUME_NONNULL_END
