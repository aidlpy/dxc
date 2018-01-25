//
//  AccountSafeCell.m
//  duxin
//
//  Created by 37duxin on 21/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "AccountSafeCell.h"

@implementation AccountSafeCell

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
        
        _descributionLab = [[UILabel alloc] initWithFrame:CGRectMake(x(_rightArrow)-108,0,100,25)];
        _descributionLab.center = CGPointMake(_descributionLab.center.x, 25);
        _descributionLab.textColor = Color_2A2A2A;
        _descributionLab.textAlignment = NSTextAlignmentRight;
        _descributionLab.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:_descributionLab];
        
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
