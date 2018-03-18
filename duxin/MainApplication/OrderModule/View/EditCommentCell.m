//
//  EditCommentCell.m
//  duxin
//
//  Created by 37duxin on 29/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "EditCommentCell.h"
#import "CWStarRateView.h"


NSString *commentPlaceHolder = @"请输入评价...";
NSString *defaultComment = @"谢谢老师，对我有很大的帮助。";
@implementation EditCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 39, 87, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.textColor = Color_1F1F1F;
        _titleLabel.text = @"服务满意度";
        [self addSubview:_titleLabel];
        
        _stars = [[CWStarRateView alloc] initWithFrame:CGRectMake(left(_titleLabel), 0, 100, 17) numberOfStars:5 canChange:YES];
        _stars.center = CGPointMake(_stars.center.x, _titleLabel.center.y);
        _stars.scorePercent = 1.0f;
        _stars.delegate = self;
        _stars.isTap = YES;
        [_stars addObserver:self forKeyPath:@"scorePercent" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        _stars.allowIncompleteStar = YES;
        
        [self addSubview:_stars];
        
        _textView = [[CustomTextView alloc] initWithFrame:CGRectMake(15, bottom(_titleLabel)+14,SIZE.width-30, 190)];
        _textView.placeholder = commentPlaceHolder;
        _textView.placeholderColor = Color_F1F1F1;
        _textView.font = _titleLabel.font;
        _textView.delegate = self;
        _textView.editable = YES;
        _textView.text = defaultComment;
        _textView.textColor = _titleLabel.textColor;
        [_textView.layer setBorderColor:Color_E5E5E5.CGColor];
        [_textView.layer setBorderWidth:1.0f];
        [_textView.layer setCornerRadius:2.0f];
        [self addSubview:_textView];
        

        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(35,bottom(_textView)+71, SIZE.width-70, 40)];
        btn.backgroundColor = Color_5ECAF7;
        [btn.layer setCornerRadius:2.0f];
        [btn setTitle:@"提交评价" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(postCommentAciton:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:btn];
    
    }
    return self;
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 方式1.匹配keypath
    if ([keyPath isEqualToString:@"scorePercent"]) {
        if (_fetchPercentBlock) {
            NSLog(@"_stars.scorePercent==>%f",_stars.scorePercent);
            _fetchPercentBlock(self.stars.scorePercent*10/2);
        }
    }

}

-(void)postCommentAciton:(UIButton *)btn{
    
    if (_postCommentBlock) {
        _postCommentBlock((int)(_stars.scorePercent*10)/2);
    }
    
    
}

//- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
//
//
//    if (_fetchPercentBlock) {
//        _fetchPercentBlock(starRateView.scorePercent/0.2);
//    }
//
//}



- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    _textView.placeholder =@"";
    return YES;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (_textView.text.length == 0) {
        _textView.placeholder =commentPlaceHolder;
    }
}

-(void)dealloc{
    [self.stars removeObserver:self forKeyPath:@"scorePercent"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
