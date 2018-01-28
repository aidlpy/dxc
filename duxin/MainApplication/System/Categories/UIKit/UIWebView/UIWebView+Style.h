//
//  UIWebView+style.h
//  vw-vip
//
//  Created by jakey on 14-3-11.
//  Copyright (c) 2014年 zhangkongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (Style)
- (void)setShadowViewHidden:(BOOL)b;
- (void)setShowsHorizontalScrollIndicator:(BOOL)b;
- (void)setShowsVerticalScrollIndicator:(BOOL)b;

-(void) makeTransparent;
-(void) makeTransparentAndRemoveShadow;
@end
