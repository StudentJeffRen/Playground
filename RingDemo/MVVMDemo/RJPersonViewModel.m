//
//  RJPersonViewModel.m
//  PlayGround
//
//  Created by 任睿杰 on 2022/8/26.
//

#import "RJPersonViewModel.h"

@implementation RJPersonViewModel

- (instancetype)initWithPerson:(RJMVVMDemoPerson *)person {
    self = [super init];
    if (!self) return nil;

    _person = person;
    if (person.salutation.length > 0) {
        _nameText = [NSString stringWithFormat:@"%@ %@ %@", self.person.salutation, self.person.firstName, self.person.lastName];
    } else {
        _nameText = [NSString stringWithFormat:@"%@ %@", self.person.firstName, self.person.lastName];
    }

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE MMMM d, yyyy"];
    _birthdateText = [dateFormatter stringFromDate:person.birthdate];

    return self;
}

@end
