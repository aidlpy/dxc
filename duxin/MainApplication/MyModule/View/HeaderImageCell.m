//
//  HeaderImageCell.m
//  duxin
//
//  Created by 37duxin on 30/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "HeaderImageCell.h"

@implementation HeaderImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //HEIGHT OF SELF CELL IS 53.0f
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 100, 25)];
        _titleLab.center =CGPointMake(_titleLab.center.x, 25);
        _titleLab.font = [UIFont systemFontOfSize:13.0f];
        _titleLab.textColor = Color_4B4B4B;
        [self addSubview:_titleLab];
        
        _rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE.width-23, 0, 8.5, 13.5)];
        _rightArrow.center = CGPointMake(_rightArrow.center.x, 25);
        [_rightArrow setImage:[UIImage imageNamed:Image(@"moreRightArrow")]];
        [self addSubview:_rightArrow];
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE.width-60, 0, 30, 30)];
        _headerImageView.center = CGPointMake(_headerImageView.center.x, _titleLab.center.y);
        _headerImageView.clipsToBounds = YES;
        [_headerImageView.layer setCornerRadius:h(_headerImageView)/2];
        [self addSubview:_headerImageView];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49.0, SIZE.width, 1)];
        _lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:_lineView];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
