//
//  RJTableViewCell.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/17.
//

#import "RJTableViewCell.h"
#import "PropertyListReformerKeys.h"

@implementation RJTableViewCell

- (void)configWithData:(NSDictionary *)dictionary {
    self.imageView.image = dictionary[kPropertyListDataKeyImage];
    self.textLabel.text = dictionary[kPropertyListDataKeyID];
}

@end
