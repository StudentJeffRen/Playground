//
//  RJDataCenter.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/17.
//

#import "RJDataCenter.h"
#import "RJTable.h"

@interface RJDataCenter ()

@property (nonatomic, strong) RJTable *table;

@end

@implementation RJDataCenter

- (NSArray *)fetchItemListWithFilter:(NSDictionary *)filter {
    // 解析 filter，取得 whereCondition，whereConditionParams
    NSString *whereCondition = @"";
    NSString *whereConditionParams = @"";
    
    // 通过 Table 对象获取数据，弱业务
    NSArray *list = [self.table findAllWithWhereCondition:whereCondition conditionParams:whereConditionParams isDistinct:NO error:NULL];
    
    // 组装数据
    NSMutableArray *resultList = [NSMutableArray array];
    [resultList addObjectsFromArray:list];
    
    return resultList;
}

@end
