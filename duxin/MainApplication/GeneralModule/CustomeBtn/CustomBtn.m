//
//  CustomBtn.m
//  HUAYI
//
//  Created by Albert on 4/5/16.
//  Copyright © 2016 zhan xingrong. All rights reserved.
//

#import "CustomBtn.h"
#import "Header.h"

@implementation CustomBtn

- (instancetype)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
    if (self) {
        _btnState = [[NSString alloc] init];
        _indexPath = [[NSIndexPath alloc] init];
      
    }
    return self;
}

- (void)setCoverColor:(UIColor *)color {
    self.userInteractionEnabled = YES;
    _bgBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, w(self), h(self))];
    _bgBtn.backgroundColor = color;
    _bgBtn.alpha = 0.6;
    [_bgBtn.layer setCornerRadius:(w(self))/2];
    _bgBtn.userInteractionEnabled = YES;
    [_bgBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bgBtn];
    
}

-(void)click:(UIButton *)button
{
    if (_buttonBlock) {
        _buttonBlock(button.superview);
    }
}

-(void)setTitleLab:(NSString *)string
{
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w(self), 20)];
    _titleLab.center = CGPointMake(self.center.x-5, self.center.y+30);
    _titleLab.text = string;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.textColor = [UIColor whiteColor];
    _titleLab.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:_titleLab];
    
}


-(void)setBackgroundColor:(UIColor *)backgroundColor state:(UIControlState)state
{
    UIImage *image = [CustomBtn createImageWithColor:backgroundColor];
    [self setBackgroundImage:image forState:state];

}


-(void)setImage:(NSString *)str UIViewContentMode:(UIViewContentMode)contentModel
{
     [_displayImgV removeFromSuperview];
    _displayImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,w(self), h(self))];
    NSString *newStr = [NSString stringWithFormat:@"%@",str];
    NSLog(@"%@",newStr);
    _displayImgV.contentMode = contentModel;
    [_displayImgV sd_setImageWithURL:[NSURL URLWithString:newStr] completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
        if (_photoShowBlock) {
            _photoShowBlock(image,_displayImgV);
        }
    }];
    [self addSubview:_displayImgV];
}

-(void)setNewImage:(UIImage *)image UIViewContentMode:(UIViewContentMode)contentModel width:(float)w height:(float)h
{
    [_displayImgV removeFromSuperview];
    _displayImgV = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-w)/2, (self.frame.size.height-h)/2,w,h)];
    _displayImgV.contentMode = UIViewContentModeScaleAspectFill;
    [_displayImgV setImage:image];
    [self addSubview:_displayImgV];
    
}

+(UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
