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
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.backgroundColor = Color_1F1F1F;
        [self addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(left(_titleLabel)+5, 0,150, 20)];
        _timeLabel.center = CGPointMake(_timeLabel.center.x,_titleLabel.center.y);
        _timeLabel.textColor = _titleLabel.textColor;
        _timeLabel.backgroundColor = Color_1F1F1F;
        [self addSubview:_timeLabel];
        
        _countLabl = [[UILabel alloc] initWithFrame:CGRectMake(SIZE.width-110, 0, 100, 20)];
        _countLabl.center = CGPointMake(_countLabl.center.x,_titleLabel.center.y);
        _countLabl.textAlignment = NSTextAlignmentRight;
        _countLabl.backgroundColor = Color_F1F1F1;
        [self addSubview:_countLabl];
        
        _commentStringLab = [[UILabel alloc] initWithFrame:CGRectMake(x(_titleLabel),bottom(_titleLabel)+10, 40, 20)];
        _commentStringLab.text = @"评价";
        _commentStringLab.textColor = Color_BABABA;
        _commentStringLab.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:_commentStringLab];
        
        _startView = [[CWStarRateView alloc] initWithFrame:CGRectMake(left(_commentStringLab),0, 100, 15) numberOfStars:5 canChange:NO];
        _startView.center = CGPointMake(_startView.center.x, _commentStringLab.center.y-1);
        _startView.scorePercent = 0.0f;
        [self addSubview:_startView];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0,bottom(_commentStringLab)+9,SIZE.width,0.5)];
        _lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:_lineView];
        
        _commentLab = [[UILabel alloc] initWithFrame:CGRectMake(14,bottom(_lineView)+17.5, SIZE.width-24, 40)];
        _commentLab.numberOfLines = 0;
        _commentLab.lineBreakMode = NSLineBreakByCharWrapping;
        _commentLab.font = [UIFont systemFontOfSize:14.0f];
        _commentLab.textColor = [UIColor blackColor];
        [self addSubview:_commentLab];
        
        _footerView = [[CommentFooter alloc]  initWithFrame:CGRectMake(0, bottom(_commentLab)+10, SIZE.width,38)];
        [self addSubview:_footerView];
    
    }
    return  self;
}

-(void)fillInCellFooter:(CommentModel *)model{
    
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _timeLabel.backgroundColor = [UIColor whiteColor];
    _countLabl.backgroundColor = [UIColor whiteColor];
    _commentLab.backgroundColor = [UIColor whiteColor];
    
    _titleLabel.text =@"深度咨询";
    NSLog(@"model.commentStart%@",model.commentStart);
    _startView.scorePercent = [model.commentStart integerValue]*0.2;
    [_countLabl setCommentTimeText:model.commentIndex];
    _timeLabel.text = [model.commentEvaluationAt timeWithTimeIntervalString];
    [_footerView updateUI:model];
    
    _commentLab.text =[NSString stringWithFormat:@"%@",model.commentEvaluation];
    // CGFloat commentHight = [_countLabl getSpaceLabelHeight:_commentLab.text withFont:_commentLab.font withWidth:w(_countLabl)]
    CGSize commentSize = [_commentLab sizeThatFits:CGSizeMake(w(_commentLab), 0)];
    [_commentLab setHeight:commentSize.height];
    model.cellHeight = commentSize.height+120;
    
    [_footerView setOriginY:bottom(_commentLab)+10];
        
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
