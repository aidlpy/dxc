//
//  CommentCell.m
//  duxin
//
//  Created by 37duxin on 28/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.clipsToBounds = YES;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 25, 70, 20)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.5f];
        _titleLabel.backgroundColor = Color_F1F1F1;
        [self addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(left(_titleLabel)+5, 0,120, 20)];
        _timeLabel.center = CGPointMake(_timeLabel.center.x,_titleLabel.center.y);
        _timeLabel.textColor = _titleLabel.textColor;
        _timeLabel.backgroundColor = Color_F1F1F1;
        [self addSubview:_timeLabel];
        
        _countLabl = [[UILabel alloc] initWithFrame:CGRectMake(SIZE.width-65, 0, 60, 20)];
        _countLabl.center = CGPointMake(_countLabl.center.x,_titleLabel.center.y);
        _countLabl.backgroundColor = Color_F1F1F1;
        [self addSubview:_countLabl];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0,bottom(_titleLabel)+9,SIZE.width,0.5)];
        _lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:_lineView];
        
        _commentLab = [[UILabel alloc] initWithFrame:CGRectMake(14,bottom(_lineView)+17.5, SIZE.width-24, 40)];
        _commentLab.numberOfLines = 0;
        _commentLab.backgroundColor = Color_F1F1F1;
        _commentLab.textColor = [UIColor blackColor];
        [self addSubview:_commentLab];
        
        _footerView = [[CommentFooter alloc]  initWithFrame:CGRectMake(0, bottom(_commentLab)+10, SIZE.width,40)];
        [self addSubview:_footerView];
    
    }
    return  self;
    
}

-(void)fillInCellFooter:(CommentModel *)model{
    
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _timeLabel.backgroundColor = [UIColor whiteColor];
    _countLabl.backgroundColor = [UIColor whiteColor];
    _commentLab.backgroundColor = [UIColor whiteColor];
    
    [_footerView updateUI:model];
    
    _titleLabel.text =@"深度咨询";
    _timeLabel.text = model.commentEvaluationAt;
    _commentLab.text = model.commentEvaluation;
    _countLabl.text = [NSString stringWithFormat:@"第%@次",model.commentIndex];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
