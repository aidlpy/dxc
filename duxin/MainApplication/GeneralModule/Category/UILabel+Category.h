//
//  UILabel+Category.h
//  duxin
//
//  Created by 37duxin on 28/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)
- (CGSize)boundingRectWithSize:(CGSize)size;
-(void)setCommentTimeText:(NSString *)string;

//计算UILabel的高度
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font;
//计算UILabel的高度(带有行间距的情况)
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;
@end
