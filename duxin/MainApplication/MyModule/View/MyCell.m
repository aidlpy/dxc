//
//  MyCell.m
//  duxin
//
//  Created by 37duxin on 19/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //HEIGHT OF SELF CELL IS 50.0f
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 25, 25)];
        _headImageView.center =CGPointMake(_headImageView.center.x, 25);
        [self addSubview:_headImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(left(_headImageView)+12,0,100,25)];
        _titleLabel.center = CGPointMake(_titleLabel.center.x, 25);
        _titleLabel.textColor = Color_2A2A2A;
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:_titleLabel];
        
        _rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE.width-23, 0, 8.5, 13.5)];
        _rightArrow.center = CGPointMake(_rightArrow.center.x, 25);
        [_rightArrow setImage:[UIImage imageNamed:Image(@"moreRightArrow")]];
        [self addSubview:_rightArrow];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49.0, SIZE.width, 1)];
        _lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:_lineView];
    
    }
    return  self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
