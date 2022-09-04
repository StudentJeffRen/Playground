//
//  RJMVVMDemoPerson.m
//  PlayGround
//
//  Created by 任睿杰 on 2022/8/26.
//

#import "RJMVVMDemoPerson.h"

@implementation RJMVVMDemoPerson

- (instancetype)initWithSalutation:(NSString *)salutation firstName:(NSString *)firstName lastName:(NSString *)lastName birthdate:(NSDate *)birthdate {
    if (self = [super init]) {
        _salutation = salutation;
        _firstName = firstName;
        _lastName = lastName;
        _birthdate = birthdate;
    }
    return self;
}

@end
