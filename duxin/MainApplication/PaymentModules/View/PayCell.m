//
//  PayCell.m
//  duxin
//
//  Created by 37duxin on 02/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "PayCell.h"

@implementation PayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //HEIGHT OF SELF CELL IS 72.5f
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 0, 28, 28)];
        _headerImageView.center = CGPointMake(_headerImageView.center.x, 50.0f/2);
        _headerImageView.clipsToBounds = YES;
        [self addSubview:_headerImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(left(_headerImageView)+11, 0, 100, 20)];
        _titleLabel.center = CGPointMake(_titleLabel.center.x, _headerImageView.center.y);
        _titleLabel.font = [UIFont systemFontOfSize:13.5f];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#1F1F1F"];
        [self addSubview:_titleLabel];
        
        _selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE.width-30,0, 18, 18)];
        _selectedImageView.center = CGPointMake(_selectedImageView.center.x,_headerImageView.center.y);
        [self addSubview:_selectedImageView];
    
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(20,49,SIZE.width-40, 1)];
        _lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:_lineView];
        
    }
    return  self;
    
}

-(void)upDateUI:(NSDictionary *)dic{
    
    [_headerImageView setImage:[UIImage imageNamed:Image([dic objectForKey:@"image"])]];
    _titleLabel.text = [dic objectForKey:@"title"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
