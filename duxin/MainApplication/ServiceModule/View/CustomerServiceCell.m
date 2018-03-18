//
//  CustomerServiceCell.m
//  duxin
//
//  Created by 37duxin on 19/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "CustomerServiceCell.h"

@implementation CustomerServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //HEIGHT OF SELF CELL IS 75.0f
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 0, 55, 55)];
        _headerImageView.center = CGPointMake(_headerImageView.center.x, 75.0f/2);
        [_headerImageView.layer setCornerRadius:_headerImageView.frame.size.height/2];
        [_headerImageView.layer setBorderWidth:0.5f];
        _headerImageView.clipsToBounds = YES;
        [_headerImageView.layer setBorderColor:Color_F1F1F1.CGColor];
        [self addSubview:_headerImageView];
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(left(_headerImageView)+10, 18, 100, 20)];
        _titleLab.font = [UIFont systemFontOfSize:16.0f];
        _titleLab.textColor = [UIColor colorWithHexString:@"#1F1F1F"];
        [self addSubview:_titleLab];
        
        _descrLab = [[UILabel alloc] initWithFrame:CGRectMake(x(_titleLab),bottom(_titleLab)+10,SIZE.width-w(_titleLab)-19, 16)];
        _descrLab.font = [UIFont systemFontOfSize:13.0f];
        _descrLab.textColor = [UIColor colorWithHexString:@"#1F1F1F"];
        [self addSubview:_descrLab];
        
        _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(SIZE.width-200,10,190, 20)];
        _timeLab.center = CGPointMake(_timeLab.center.x, _titleLab.center.y);
        _timeLab.font = [UIFont systemFontOfSize:13.0f];
        _timeLab.textAlignment = NSTextAlignmentRight;
        _timeLab.textColor = [UIColor colorWithHexString:@"#1F1F1F"];
        [self addSubview:_timeLab];
        
        _unreadLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIZE.width-40, bottom(_timeLab)+5, 20, 20)];
        _unreadLabel.backgroundColor = [UIColor redColor];
        _unreadLabel.textColor = [UIColor whiteColor];
        _unreadLabel.textAlignment = NSTextAlignmentCenter;
        _unreadLabel.font = [UIFont systemFontOfSize:12.0f];
        [_unreadLabel.layer setCornerRadius:h(_unreadLabel)/2];
        _unreadLabel.clipsToBounds = YES;
       
        [self addSubview:_unreadLabel];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0,74.5,SIZE.width, 1)];
        _lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:_lineView];
    
    }
    return  self;
    
}


-(void)setDefaultStytle{
    
    [_headerImageView setBackgroundColor:Color_F1F1F1];
    [_titleLab setBackgroundColor:Color_F1F1F1];
    [_descrLab setBackgroundColor:Color_F1F1F1];
    [_timeLab setBackgroundColor:Color_F1F1F1];
    
}

-(void)updateUIModel:(EMFriendModel *)model{
    
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.emFriendsAvatar]];
    [_titleLab setText:model.emFriendsNickname];
    _timeLab.text = model.emCreated_at;
    _descrLab.text = model.lastMessage;
    if ([model.unreadMessageCount isEqualToString:@"0"]) {
        _unreadLabel.hidden = YES;
    }
    else
    {
        _unreadLabel.hidden = NO;
        if ([model.unreadMessageCount integerValue] > 99) {
            model.unreadMessageCount =@"99+";
            [_unreadLabel setMj_w:25.0f];
            [_unreadLabel setMj_h:25.0f];
            [_unreadLabel.layer setCornerRadius:h(_unreadLabel)/2];
        }
        else
        {
            [_unreadLabel setMj_w:20.0f];
            [_unreadLabel setMj_h:20.0f];
            [_unreadLabel.layer setCornerRadius:h(_unreadLabel)/2];
        }
        _unreadLabel.text = model.unreadMessageCount;
        
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
