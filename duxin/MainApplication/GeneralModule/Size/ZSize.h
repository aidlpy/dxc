//
//  ZSize.h
//  linesphoto
//
//  Created by Albert on 5/14/16.
//  Copyright © 2016 Albert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define SIZE [UIScreen mainScreen].bounds.size
@interface ZSize : NSObject
CGSize zsize(CGSize size);
CGPoint zpoint(CGPoint point);
CGRect zrect (CGRect frame);
CGFloat xfloat(CGFloat zxfloat);
CGFloat yfloat(CGFloat zxfloat);
CGFloat bottom (UIView *view);
CGFloat left (UIView *view);
CGFloat x (UIView *view);
CGFloat y (UIView *view);
CGFloat w (UIView *view);
CGFloat h (UIView *view);
CGFloat halfX (CGFloat weight);
CGFloat halfY (CGFloat height);
CGFloat percent(int m,int g);
bool checktType(NSString *str);
+(NSString*)get:(NSString *)str;
+(NSString*)getpercent:(float)percent;
+(CGFloat)sizeWidth:(UILabel *)label;
@end
