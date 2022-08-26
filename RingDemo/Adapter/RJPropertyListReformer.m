//
//  RJPropertyListReformer.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/17.
//

#import "RJPropertyListReformer.h"
#import "RJAPIManager.h"

NSString * const kPropertyListDataKeyID = @"kPropertyListDataKeyID";
NSString * const kPropertyListDataKeyName = @"kPropertyListDataKeyName";
NSString * const kPropertyListDataKeyTitle = @"kPropertyListDataKeyTitle";
NSString * const kPropertyListDataKeyImage = @"kPropertyListDataKeyImage";

@implementation RJPropertyListReformer
- (NSDictionary *)reformData:(NSDictionary *)originData fromManager:(RJAPIManager *)manager {
    NSDictionary *resultData = nil;
    
    // 不同 api 给的字段不一样
    if ([manager isKindOfClass:[RJAPIManager class]]) {
        resultData = @{
            kPropertyListDataKeyID:originData[@"id"],
            kPropertyListDataKeyName:originData[@"name"],
            kPropertyListDataKeyTitle:originData[@"title"],
            kPropertyListDataKeyImage:originData[@"imageUrl"]
        };
    }
    
//    if ([manager isKindOfClass:[XinFangListAPIManager class]]) {
//        resultData = @{
//            kPropertyListDataKeyID:originData[@"xinfang_id"],
//            kPropertyListDataKeyName:originData[@"xinfang_name"],
//            kPropertyListDataKeyTitle:originData[@"xinfang_title"],
//            kPropertyListDataKeyImage:[UIImage imageWithUrlString:originData[@"xinfang_imageUrl"]]
//        };
//    }
    
    return resultData;
}
@end
