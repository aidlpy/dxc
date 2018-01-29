//
//  CustomTextView.m
//  duxin
//
//  Created by 37duxin on 29/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "CustomTextView.h"

@implementation CustomTextView
-(instancetype)init{
    if (self = [super init]) {
        // 设置默认字
        self.font = [UIFont systemFontOfSize:17];
        // 设置默认颜色
        self.placeholderColor = [UIColor grayColor];
        // 使用通知监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

-(void)textDidChange:(NSNotification *)note{
    // 会重新调用drawRect:方法
    [self setNeedsDisplay];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)drawRect:(CGRect)rect{
    // 如果有文字，就直接返回，不需要画占位文字
    if (self.hasText) return;
    
    // 属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    // 画文字
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:attrs];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

@end
