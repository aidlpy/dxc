//
//  ShConsultantJudgeTableViewCell.m
//  duxin
//
//  Created by felix on 2018/1/27.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import "ShConsultantJudgeTableViewCell.h"

#define CELL_HEIGHT 10 + 60 + 10 + 40 + 10 + 20 + 10  = 

@implementation ShConsultantJudgeTableViewCell

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
    self.photoImageView.image = [UIImage imageNamed:@""];
    self.photoImageView.layer.cornerRadius = 60/2;
    self.photoImageView.clipsToBounds = YES;
    self.photoImageView.layer.borderColor = Color_CBE3E8.CGColor;
    self.photoImageView.backgroundColor = Color_5DCBF5;
    self.photoImageView.layer.borderWidth = 1;
    [self.contentView addSubview:self.photoImageView];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.top.mas_equalTo(13);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text  = @"莫菲菲喵咪";
    self.nameLabel.font = FONT_15;
    self.nameLabel.textColor = Color_1F1F1F;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.photoImageView.mas_right).offset(10);
        make.top.equalTo(self.photoImageView.mas_top).offset(5);
        make.height.mas_equalTo(20);
    }];
    
    self.sexImageView = [[UIImageView alloc] init];
    self.sexImageView.image = [UIImage imageNamed:Image(@"commentMan")];
    [self.contentView addSubview:self.sexImageView];
    [self.sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_top);
        make.left.equalTo(self.nameLabel.mas_right).offset(5);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.text  = @"今天20：10 来自Android客户端";
    self.timeLabel.font = FONT_11;
    self.timeLabel.textColor = Color_3A3A3A;
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    CGFloat pointX = 13 + 60 + 10;
    CGFloat pointY = 13 + 60 + 10;
    self.startNum = [[CWStarRateView alloc] initWithFrame:CGRectMake(pointX, 60, 80, 30) numberOfStars:5 canChange:NO];
    self.startNum.scorePercent = 0.4;
    [self.contentView addSubview:self.startNum];
    
    self.commentLabel = [[UILabel alloc] init];
    self.commentLabel.text = @"还是让我有点迷惑，还是不知所错，专业态度好";
    self.commentLabel.font = FONT_14;
    self.commentLabel.textColor = Color_2B2B2B;
    self.commentLabel.numberOfLines = 0;
    self.commentLabel.lineBreakMode = UILineBreakModeWordWrap;
    [self.contentView addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.mas_equalTo(pointY);
        make.right.mas_equalTo(-30);
        make.bottom.mas_equalTo(-10);
    }];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = Color_EEEEEE;
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
}
-(void)reloadUI:(ShConsultantCommentDetailModel *)commentModel
{
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.user.avatar]];
    self.nameLabel.text = commentModel.user.nickname;
    if (commentModel.user.gender == 1) {
        self.sexImageView.hidden = NO;
        self.sexImageView.image = [UIImage imageNamed:Image(@"commentMan")];
    }else if(commentModel.user.gender == 2)
    {
        self.sexImageView.hidden = NO;
        self.sexImageView.image = [UIImage imageNamed:Image(@"commentWoman")];

    }else{
        self.sexImageView.hidden = YES;
    }
    self.timeLabel.text  = @"今天20：10 来自Android客户端";

    switch (commentModel.user.device) {
        case 0:
            self.timeLabel.text = [NSString stringWithFormat:@"%zd 来自Android客户端",commentModel.evaluation_at];
        case 1:
            self.timeLabel.text = [NSString stringWithFormat:@"%zd 来自iOS客户端",commentModel.evaluation_at];
        case 2:
            self.timeLabel.text = [NSString stringWithFormat:@"%zd 来自PC客户端",commentModel.evaluation_at];
            break;
            
        default:
            break;
    }
    
    self.startNum.scorePercent = commentModel.start / 5;
    self.commentLabel.text = commentModel.evaluation;

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
