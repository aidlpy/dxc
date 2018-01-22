//
//  ServiceBtn.m
//  duxin
//
//  Created by 37duxin on 19/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ServiceBtn.h"

@implementation ServiceBtn


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(75,14,25,27)];
        _logoImageView.center = CGPointMake(self.center.x, _logoImageView.center.y);
        [self  addSubview:_logoImageView];
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0,bottom(_logoImageView)+7,100,20)];
        _titleLab.center = CGPointMake(_logoImageView.center.x, _titleLab.center.y);
        _titleLab.textColor = Color_1F1F1F;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:12.5];
        [self addSubview:_titleLab];
    }
    
    return self;
}

-(void)setImage:(NSString *)imageStr setTitle:(NSString *)string{
    
    [_logoImageView setImage:[UIImage imageNamed:Image(imageStr)]];
    _titleLab.text = string;
    
}

@end
