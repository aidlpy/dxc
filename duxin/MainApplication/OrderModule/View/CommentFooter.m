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
        _headerImageView.backgroundColor = Color_F1F1F1;
        [_headerImageView.layer setCornerRadius:h(_headerImageView)/2];
        [self addSubview:_headerImageView];
        
        _textLabel = [[UILabel  alloc] initWithFrame:CGRectMake(left(_headerImageView)+7, _headerImageView.center.y-10, SIZE.width-60,20)];
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.font = [UIFont systemFontOfSize:15.0f];
        _textLabel.backgroundColor = Color_F1F1F1;
        [self addSubview:_textLabel];
        
    }
    return self;
}

-(void)updateUI:(CommentModel *)model{
    
    _textLabel.text = model.commentReply;
    CGSize size =  [_textLabel sizeThatFits:CGSizeMake(w(_textLabel), 0)];
    model.footerHeight = size.height;
    _textLabel.frame = CGRectMake(x(_textLabel), y(_textLabel),size.width, size.height);
    NSLog(@"model.commentReply==>%@",model.commentReply);
    CGSize commentSize = [_textLabel sizeThatFits:CGSizeMake(w(_textLabel), 0)];
      NSLog(@"commentSize==>%f",commentSize.height);
    [_textLabel setWidth:commentSize.width];
}

@end
