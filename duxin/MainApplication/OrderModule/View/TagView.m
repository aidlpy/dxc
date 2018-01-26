//
//  TagView.m
//  duxin
//
//  Created by 37duxin on 25/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "TagView.h"

@implementation TagView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _headerImagV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,15,16)];
        [self addSubview:_headerImagV];
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(left(_headerImagV)+5,0, self.frame.size.width-_headerImagV.frame.size.width,self.frame.size.height)];
        _titleLab.textColor = Color_1F1F1F;
        _titleLab.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:_titleLab];
        
    }
    
    return self;
}



@end
