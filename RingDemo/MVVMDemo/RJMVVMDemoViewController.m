//
//  RJMVVMDemoViewController.m
//  PlayGround
//
//  Created by 任睿杰 on 2022/8/11.
//

#import "RJMVVMDemoViewController.h"
#import "RJMVVMDemoPerson.h"
#import "RJPersonViewModel.h"

@interface RJMVVMDemoViewController ()

@property (nonatomic, strong) RJMVVMDemoPerson *model;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *birthdateLabel;
@property (nonatomic, strong) RJPersonViewModel *viewModel;

@end

@implementation RJMVVMDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 20)];
    self.birthdateLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 100, 20)];
    
    self.viewModel = [[RJPersonViewModel alloc] initWithPerson:self.model];
    self.nameLabel.text = self.viewModel.nameText;
    self.birthdateLabel.text = self.viewModel.birthdateText;
    
    // 这一坨弱业务逻辑都放到 viewModel 中处理
//    if (self.model.salutation.length > 0) {
//        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@ %@", self.model.salutation, self.model.firstName, self.model.lastName];
//    } else {
//        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.model.firstName, self.model.lastName];
//    }
//
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"EEEE MMMM d, yyyy"];
//    self.birthdateLabel.text = [dateFormatter stringFromDate:self.model.birthdate];
    
    
}

@end
