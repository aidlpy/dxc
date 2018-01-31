//
//  ShCollectTableViewCell.m
//  duxin
//
//  Created by felix on 2018/1/31.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import "ShCollectTableViewCell.h"

#define HEIGHT_135 135
#define HEIGHT_40 40


@implementation ShCollectTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    self.leftTitleLabel = [[UILabel alloc] init];
    self.leftTitleLabel.text = @"什么样的爱情可以更持久";
    self.leftTitleLabel.textColor = Color_1F1F1F;
    self.leftTitleLabel.font = FONT_20;
    [self.contentView addSubview:self.leftTitleLabel];
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-100);
        make.height.mas_equalTo(25);
    }];
    
    self.LeftContentLabel = [[UILabel alloc] init];
    self.LeftContentLabel.text = @"这个人真都可以和我么长久的走下么？如何嫩和他/更好沟通呢？";
    self.LeftContentLabel.textColor = Color_BABABA;
    self.LeftContentLabel.font = FONT_14;
    self.LeftContentLabel.numberOfLines = 0;
    self.LeftContentLabel.lineBreakMode = UILineBreakModeWordWrap;
    [self.contentView addSubview:self.LeftContentLabel];
    [self.LeftContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTitleLabel.mas_left);
        make.top.equalTo(self.leftTitleLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(self.leftTitleLabel.mas_right);
        make.height.mas_equalTo(-60);
    }];
    
    self.photoImageView = [[UIImageView alloc] init];
    self.photoImageView.backgroundColor =Color_EEEEEE;
    self.photoImageView.layer.cornerRadius = HEIGHT_40/2;
    self.photoImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.photoImageView];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftTitleLabel.mas_left);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(HEIGHT_40);
        make.height.mas_equalTo(HEIGHT_40);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"莫菲菲";
    self.nameLabel.textColor = Color_BABABA;
    self.nameLabel.font = FONT_13;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.photoImageView.mas_right).offset(8);
        make.top.equalTo(self.photoImageView.mas_top).offset(5);
        make.right.mas_equalTo(self.leftTitleLabel.mas_right);
        make.height.mas_equalTo(15);
    }];
    
    self.tagLabel = [[UILabel alloc] init];
    self.tagLabel.text = @"心理咨询师";
    self.tagLabel.textColor = Color_BABABA;
    self.tagLabel.font = FONT_11;
    [self.contentView addSubview:self.tagLabel];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.right.mas_equalTo(self.leftTitleLabel.mas_right);
        make.height.mas_equalTo(15);
    }];
    
    self.rightImageView = [[UIImageView alloc] init];
    self.rightImageView.backgroundColor =Color_EEEEEE;
    self.rightImageView.layer.cornerRadius = 4;
    self.rightImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(HEIGHT_40*2);
        make.height.mas_equalTo(HEIGHT_40*2);
    }];
    
    self.viewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.viewBtn layoutButtonWithEdgeInsetsStyle:UIButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [self.viewBtn setTitle:@"1000" forState:UIControlStateNormal];
    [self.viewBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.viewBtn setTitleColor:Color_BABABA forState:UIControlStateNormal];
    self.viewBtn.titleLabel.font = FONT_11;
    [self.contentView addSubview:self.viewBtn];
    [self.viewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImageView.mas_right);
        make.bottom.mas_equalTo(-20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
    }];
}

-(void)reloadUI:(ShCollectDetailModel *)model
{
    self.leftTitleLabel.text = model.magazine.title;
    self.LeftContentLabel.text = model.magazine.briefly;
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:model.magazine.head_figure]];
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:model.magazineUser.avatar]];
    self.nameLabel.text = model.magazineUser.nickname;
    self.tagLabel.text = @"心理咨询师";
    [self.viewBtn setTitle:[NSString stringWithFormat:@"%zd",model.magazine.views] forState:UIControlStateNormal];
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
