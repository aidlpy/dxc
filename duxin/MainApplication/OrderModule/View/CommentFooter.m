//
//  CommentFooter.m
//  duxin
//
//  Created by 37duxin on 28/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "CommentFooter.h"

@implementation CommentFooter

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 37, 37)];
        _headerImageView.clipsToBounds = YES;
        _headerImageView.backgroundColor = Color_F1F1F1;
        [_headerImageView.layer setCornerRadius:h(_headerImageView)/2];
        [self addSubview:_headerImageView];
        
        _textLabel = [[UILabel  alloc] initWithFrame:CGRectMake(left(_headerImageView)+7, _headerImageView.center.y-10, SIZE.width-60,0)];
        _textLabel.numberOfLines = 0;
        _textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _textLabel.textColor = Color_1F1F1F;
        _textLabel.font = [UIFont systemFontOfSize:14.0f];
        _textLabel.backgroundColor = Color_1F1F1F;
        [self addSubview:_textLabel];
        
    }
    return self;
}

-(void)updateUI:(CommentModel *)model{
  
    if (model.commentReply) {
        
        [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.commentAvatar]];
        _textLabel.text =[NSString stringWithFormat:@"咨询师回复:%@",model.commentReply];
        _textLabel.backgroundColor = [UIColor whiteColor];
        CGSize size =  [_textLabel sizeThatFits:CGSizeMake(w(_textLabel), 0)];//计算高度
        model.footerHeight = size.height+30.0f;//高度给footer
        [_textLabel setHeight:size.height ];//textLabel
        [self setHeight:model.footerHeight];
        
    }
    else{
        
        model.footerHeight = 0.001f;
    }

    
}

@end
