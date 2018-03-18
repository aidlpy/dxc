//
//  ShConsultantDetailTableViewCell.m
//  duxin
//
//  Created by felix on 2018/1/25.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import "ShConsultantDetailTableViewCell.h"

#define CELL_HEIGTH_65  65

@implementation ShConsultantDetailTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 13, SIZE.width - 200, 20)];
    self.titleLabel.textColor = Color_1F1F1F;
    self.titleLabel.font = FONT_13;
    self.titleLabel.text = @"分析问题，寻找原因";
    [self.contentView addSubview:self.titleLabel];
    
    self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, 200, 20)];
    self.leftLabel.textColor = Color_BABABA;
    self.leftLabel.font = FONT_13;
    self.leftLabel.text = @"50元/次 （1小时）， 1次";
    
    [self.contentView addSubview:self.leftLabel];
    
    CGFloat pointX = self.leftLabel.frame.origin.x + self.leftLabel.frame.size.width + 20;
    self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftLabel.frame.origin.x + self.leftLabel.frame.size.width + 20, self.leftLabel.frame.origin.y, SIZE.width - pointX - 15, 20)];
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    self.rightLabel.textColor = Color_BABABA;
    self.rightLabel.font = FONT_13;
    self.rightLabel.text = @"销量6 评分4.6";
    [self.contentView addSubview:self.rightLabel];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = Color_EEEEEE;
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
}

-(void)reloadUI:(ShConsultantPackageModel *)packageModel
{
    
    self.titleLabel.text = packageModel.title;
    NSString *strLeft = [NSString stringWithFormat: @"%.2lf元/次（%ld分钟）， %ld次",packageModel.single_price,(long)packageModel.service_hours,(long)packageModel.service_times];
    NSMutableAttributedString *strGood = [[NSMutableAttributedString alloc] initWithString:strLeft];

    NSString *strLeft1 =[NSString stringWithFormat:@"%.2lf元",packageModel.single_price];
    [strGood addAttribute:NSForegroundColorAttributeName value:Color_57CAF7 range:NSMakeRange(0,strLeft1.length)];
    [self.leftLabel setAttributedText:strGood];

    NSString *strRight = [NSString stringWithFormat:@"销量%zd 评分%.1lf",packageModel.sales,packageModel.score];
    self.rightLabel.text =strRight;
    
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
