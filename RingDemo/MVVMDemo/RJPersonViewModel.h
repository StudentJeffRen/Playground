//
//  RJPersonViewModel.h
//  PlayGround
//
//  Created by 任睿杰 on 2022/8/26.
//

#import <Foundation/Foundation.h>
#import "RJMVVMDemoPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJPersonViewModel : NSObject

- (instancetype)initWithPerson:(RJMVVMDemoPerson *)person;

@property (nonatomic, readonly) RJMVVMDemoPerson *person;

@property (nonatomic, readonly) NSString *nameText;
@property (nonatomic, readonly) NSString *birthdateText;

@end

NS_ASSUME_NONNULL_END
