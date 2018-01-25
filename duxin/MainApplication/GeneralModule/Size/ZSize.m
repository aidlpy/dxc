//
//  ZSize.m
//  linesphoto
//
//  Created by Albert on 5/14/16.
//  Copyright © 2016 Albert. All rights reserved.
//

#import "ZSize.h"
#import "Header.h"

#define ratio 320
@implementation ZSize

CGSize zsize(CGSize size)
{
    size = CGSizeMake(size.width*(SIZE.width/375), size.height*(SIZE.height/667));
    return size;
}

CGPoint zpoint(CGPoint point)
{
    point = CGPointMake(point.x*(SIZE.width/750), point.y*(SIZE.width/750));
    return point;
}

CGRect zrect (CGRect frame)
{
    frame = CGRectMake(frame.origin.x *(SIZE.width/375),frame.origin.y*(SIZE.height/667),frame.size.width*(SIZE.width/375), frame.size.width*(SIZE.height/667));
    return frame;
}

CGFloat xfloat(CGFloat zxfloat)
{
    zxfloat = zxfloat *(SIZE.width/375);
    return zxfloat;

}

CGFloat yfloat(CGFloat zxfloat)
{
    zxfloat = zxfloat *(SIZE.width/667);
    return zxfloat;
    
}

CGFloat bottom (UIView *view)
{
    
    CGFloat y = view.frame.origin.y+view.frame.size.height;
    return y;

}

CGFloat left (UIView *view)
{
    
    CGFloat x = view.frame.origin.x +view.frame.size.width;
    return x;
}

CGFloat x (UIView *view)
{
    return view.frame.origin.x;

}

CGFloat y (UIView *view)
{

    return view.frame.origin.y;
}

CGFloat w (UIView *view)
{
    return view.frame.size.width;

}


CGFloat h (UIView *view)
{
    return view.frame.size.height;
    
}

CGFloat halfX (CGFloat weight)
{

    return weight/2;

}

CGFloat halfY (CGFloat height)
{
    
    return height/2;
    
}

CGFloat percent(int m,int g)
{
    CGFloat percent;
   percent = m/g;
    return percent;
}

bool checktType(NSString *str)
{
    bool type;
  
    if ([[str substringWithRange:NSMakeRange(str.length-3, 3)] isEqualToString:@"jpg"]) {
         type = YES;
    }
    else
    {
        type = NO;
    }
    
    return type;
}


+(NSString*)get:(NSString *)str
{
    NSString *number = [NSString new];
    int i ;
    for (i = 0; i<str.length; i++) {
        NSString *temp = [str substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"p"]) {
           number = [str substringWithRange:NSMakeRange(i+1, str.length-(i+1))];
        }
    }
    return number;
}

+(NSString*)getpercent:(float)percent
{
    NSString *str = [NSString stringWithFormat:@"%f",percent];
    NSString *number = [NSString new];
    int i ;
    for (i = 0; i<str.length; i++) {
        NSString *temp = [str substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"."]) {
            number = [str substringWithRange:NSMakeRange(i+1,2)];
            if ([number isEqualToString:@"00"]) {
                number = @"100";
            }
        }
    }
    return number;
}



@end
