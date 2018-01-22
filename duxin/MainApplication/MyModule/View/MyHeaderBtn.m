//
//  MyHeaderBtn.m
//  duxin
//
//  Created by 37duxin on 19/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MyHeaderBtn.h"

@implementation MyHeaderBtn

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 20.0f, 21.5f)];
        self.logoImageView.center = CGPointMake(frame.size.width/2, self.logoImageView.center.y);
        [self addSubview:self.logoImageView];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0,bottom(self.logoImageView)+4,self.frame.size.width,10)];
        self.titleLab.center = CGPointMake(self.logoImageView.center.x, self.titleLab.center.y);
        self.titleLab.font = [UIFont systemFontOfSize:8.5f];
        self.titleLab.textColor = Color_2E2E2E;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLab];
        
    }
    return self;
}


-(void)setImage:(NSString *)imageStr setTitle:(NSString *)string{
    
    [self.logoImageView setImage:[UIImage imageNamed:Image(imageStr)]];
    self.titleLab.text = string;
    
}

@end
