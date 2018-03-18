//
//  MyConselorCell.m
//  duxin
//
//  Created by 37duxin on 19/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MyConselorCell.h"

@implementation MyConselorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //HEIGHT OF SELF CELL IS 72.5f
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 0, 50, 50)];
        _headerImageView.center = CGPointMake(_headerImageView.center.x, 75.0f/2);
        [_headerImageView.layer setCornerRadius:_headerImageView.frame.size.height/2];
        [_headerImageView.layer setBorderWidth:0.5f];
        [_headerImageView.layer setBorderColor:Color_F1F1F1.CGColor];
        [_headerImageView setBackgroundColor:Color_F1F1F1];
        [_headerImageView setClipsToBounds:YES];
        [self addSubview:_headerImageView];
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(left(_headerImageView)+13, 0, 100, 20)];
        _titleLab.center = CGPointMake(_titleLab.center.x, _headerImageView.center.y);
        _titleLab.font = [UIFont systemFontOfSize:13.5f];
        _titleLab.textColor = [UIColor colorWithHexString:@"#1F1F1F"];
        _titleLab.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titleLab];
        
        _rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE.width-24,0,11,14)];
        _rightArrow.center = CGPointMake(_rightArrow.center.x,_headerImageView.center.y);
        [_rightArrow setImage: [UIImage imageNamed:Image(@"grayRightArrow")]];
        [self addSubview:_rightArrow];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0,74.5,SIZE.width, 1)];
        _lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:_lineView];
        
    }
    return  self;
    
}
-(void)reloadUI:(ShConsultantInfoModel *)attentionModel
{
//    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:attentionModel.avatar] placeholderImage:Image(@".jpg")];
    self.titleLab.text =attentionModel.name;
}

-(void)setDefaultStytleWithData:(CustomerServiceModel *)model{
    
   self.titleLab.text =model.consultantProfileName;
   [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.consultantProfileAvatar]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
