//
//  LoginView.m
//  duxin
//
//  Created by 37duxin on 20/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //Deflaut Height 100PX = 50
       
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(23, 16,20,24)];
        _logoImageView.center = CGPointMake(_logoImageView.center.x, h(self)/2);
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_logoImageView];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(left(_logoImageView)+19, 0, SIZE.width-57,22)];
        _textField.center = CGPointMake(_textField.center.x, _logoImageView.center.y);
        _textField.font =FONT_14;
        [_textField setValue:Color_BABABA forKeyPath:@"_placeholderLabel.textColor"];
        [_textField setValue:FONT_13 forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_textField];
        
        _codeBtn = [[JKCountDownButton alloc] initWithFrame:CGRectMake(SIZE.width-110, 0, 100, 22)];
        _codeBtn.center =CGPointMake(_codeBtn.center.x, _textField.center.y);
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:Color_5ECAF7 forState:UIControlStateNormal];
        [_codeBtn addTarget:self  action:@selector(fetchCodeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_codeBtn setHidden:YES];
        [self addSubview:_codeBtn];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(20,self.frame.size.height-1,SIZE.width-40,1)];
        _lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:_lineView];
        
    }
    return self;
}

-(void)fetchCodeAction:(JKCountDownButton *)sender{

    if (_codeBlock) {
        _codeBlock(sender);
    }

}

-(void)setLogoImageView:(NSString *)imageStr setPlaceHolder:(NSString *)placeHolder{
    
    [_logoImageView setImage:[UIImage imageNamed:Image(imageStr)]];
    [_textField setPlaceholder:placeHolder];
    
}


@end
