//
//  CounselorCell.m
//  duxin
//
//  Created by 37duxin on 02/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "CounselorCell.h"

@implementation CounselorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8,12, 54, 54)];
        _headerImageView.clipsToBounds = YES;
        _headerImageView.backgroundColor = [UIColor grayColor];
        [_headerImageView.layer setCornerRadius:h(_headerImageView)/2];
        [self addSubview:_headerImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(left(_headerImageView)+8,17,SIZE.width-w(_headerImageView)-16, 22)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = Color_1F1F1F;
        [self addSubview:_titleLabel];
        
//        _areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>))];
  
    }
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
