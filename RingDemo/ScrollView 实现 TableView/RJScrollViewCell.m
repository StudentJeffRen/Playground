//
//  RJScrollViewCell.m
//  RingDemo
//
//  Created by 任睿杰 on 2022/10/4.
//

#import "RJScrollViewCell.h"

@interface RJScrollViewCell ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation RJScrollViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.colors = @[(id)[[ UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
                                      (id)[[ UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
                                      (id)[[ UIColor clearColor] CGColor],
                                      (id)[[ UIColor colorWithWhite:0.0f alpha:0.1f] CGColor]];
            _gradientLayer.locations = @[@0.00f,@0.01f,@0.95f,@1.00f];
            [self.layer insertSublayer:_gradientLayer above:0];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
