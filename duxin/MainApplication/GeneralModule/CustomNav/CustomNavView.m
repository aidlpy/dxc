//
//  CustomNavView.m
//  HUAYI
//
//  Created by Albert on 7/19/16.
//  Copyright © 2016 zhan xingrong. All rights reserved.
//


#import "CustomNavView.h"
#import "Header.h"
#define W_SCREEN [UIScreen mainScreen].bounds.size.width
#define H_SCREEN [UIScreen mainScreen].bounds.size.height


@implementation CustomNavView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self commonInit];
        
    }
    return self;
}

-(void)commonInit{
    self.frame = CGRectMake(0, 0, SIZE.width, Height_NavBar);
    self.backgroundColor = [UIColor whiteColor];
    //creat a  Label at the middle place of navigationBar
    //创建一个label在navigationBar中间
    
    _middleBtn = [[CustomBtn alloc] initWithFrame:CGRectMake((SIZE.width-250)/2, Height_StatusBar, 250, 44)];
    
    _leftBtn = [[CustomBtn alloc] initWithFrame:CGRectMake(0,Height_StatusBar, 45, 45)];
    _leftBtn.backgroundColor = [UIColor clearColor];
    [_leftBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _rightBtn = [[CustomBtn alloc] initWithFrame:CGRectMake(W_SCREEN - 50, Height_StatusBar, 45, 45)];
    _rightBtn.backgroundColor = [UIColor clearColor];
    [_rightBtn addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
   

    [self addSubview:_middleBtn];
    [self addSubview:_leftImaV];
    [self addSubview:_leftBtn];
    [self addSubview:_rightBtn];
}

-(void)setBackStytle:(NSString *)title rightImage:(NSString *)rightImageStr{
    
    [self.middleBtn setTitle:title forState:UIControlStateNormal];
    [self.middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.leftBtn.center = CGPointMake(self.leftBtn.center.x,self.center.y+5);
    [self.leftBtn setImage:[UIImage imageNamed:Image(rightImageStr)] forState:UIControlStateNormal];
    [self.middleBtn.titleLabel setFont:FONT_18];
    
}



-(void)backAction:(id)sender
{
    if (_backBlock) {
        _backBlock();
    }
}

-(void)pushAction:(id)sender
{
    if (_pushBlock) {
        _pushBlock();
    }
}




@end
