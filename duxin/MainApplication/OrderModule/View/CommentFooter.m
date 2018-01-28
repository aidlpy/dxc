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
        
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 37, 37)];
        _headerImageView.backgroundColor = Color_F1F1F1;
        [_headerImageView.layer setCornerRadius:h(_headerImageView)/2];
        [self addSubview:_headerImageView];
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(left(_headerImageView)+7, _headerImageView.center.y-10, SIZE.width-60,20)];
        _textView.editable = NO;
        _textView.scrollEnabled = NO;
        _textView.textColor = [UIColor blackColor];
        _textView.font = [UIFont systemFontOfSize:15.0f];
        _textView.backgroundColor = Color_F1F1F1;
        [self addSubview:_textView];
        
    }
    return self;
}

@end
