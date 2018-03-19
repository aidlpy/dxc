//
//  ShConstultTableViewCell.m
//  duxin
//
//  Created by felix on 2018/2/4.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import "ShConstultTableViewCell.h"

#define HEIGHT_60 60
#define CELLHEIGTH_130 130
@implementation ShConstultTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    
    self.photoImageView = [[UIImageView alloc] init];
    self.photoImageView.backgroundColor =Color_EEEEEE;
    self.photoImageView.layer.cornerRadius = HEIGHT_60/2;
    self.photoImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.photoImageView];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(HEIGHT_60);
        make.height.mas_equalTo(HEIGHT_60);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"曹丽君";
    self.nameLabel.textColor = Color_1F1F1F;
    self.nameLabel.font = FONT_18;
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.photoImageView.mas_right).offset(10);
        make.top.equalTo(self.photoImageView.mas_top).offset(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.text = @"北京";
    self.addressLabel.textColor = Color_1F1F1F;
    self.addressLabel.font = FONT_13;
    self.addressLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(self.nameLabel.mas_right);
        make.height.equalTo(self.nameLabel.mas_height);
    }];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = Color_EEEEEE;
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
}

-(void)reloadUI:(ShConsultModel *)model
{
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar]];
    self.nameLabel.text = model.name;
    self.addressLabel.text = model.city;
    
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag >=100) {
            [obj removeFromSuperview];
        }
    }];
    
    NSArray *tagArray = [model.tags componentsSeparatedByString:@","];
    CGFloat labelWidth = 75;
    CGFloat labelHeight = 25;
    CGFloat labelDistance = 10;
    CGFloat labelPoineY = HEIGHT_60 + 15;
    [tagArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat labelPointX = HEIGHT_60 + 20 + (labelWidth + labelDistance) *idx;
        UILabel *tagLabel = [[UILabel alloc] init];
        tagLabel.frame = CGRectMake(labelPointX, labelPoineY, labelWidth, labelHeight);
        tagLabel.text = obj;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.textColor = Color_1F1F1F;
        tagLabel.font = FONT_13;
        tagLabel.layer.cornerRadius = labelHeight/2;
        tagLabel.clipsToBounds = YES;
        tagLabel.layer.borderColor = Color_1F1F1F.CGColor;
        tagLabel.layer.borderWidth = 0.5;
        tagLabel.tag = 1000 + idx;
        [self.contentView addSubview:tagLabel];
    }];


    
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
