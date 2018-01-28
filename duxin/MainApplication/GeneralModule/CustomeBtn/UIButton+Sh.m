//
//  UIButton+Sh.m
//  LeeMall
//
//  Created by 沈宗琪 on 2017/3/16.
//  Copyright © 2017年 MaxWellPro. All rights reserved.
//

#import "UIButton+Sh.h"
#import <objc/runtime.h>

@implementation UIButton (Sh)
static char *actNameKey = "BtnClickState";
static char *imgOrderKey = "imgOrderKey";
static char *labNameKey = "labNameKey";
static char *indexPathKey = "indexPathKey";
static char *isClickedKey = "isClickedKey";
static char *strCatIDKey = "strCatIDKey";
static char *dicMsgKey = "dicMsgKey";
static char *intCountKey = "intCountKey";
static char *floatPriceKey = "floatPriceKey";
static char *strTypeNameKey = "strTypeNameKey";
static char *pointKey = "pointKey";
static char *viewControllertKey = "viewControllertKey";
static char *calendarDayModelKey = "calendarDayModelKey";
static char *textFieldKey = "textFieldKey";
static char *label1Key = "label1Key";
static char *label2Key = "label2Key";
static char *workModelKey = "workModelKey";
static char *imgModelKey = "imgModelKey";

- (void)layoutButtonWithEdgeInsetsStyle:(UIButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case UIButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case UIButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case UIButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case UIButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

-(CGFloat)sizeWidth
{
    
    NSDictionary *dic=@{NSFontAttributeName:self.titleLabel.font};
    
    CGSize size=[self.titleLabel.text sizeWithAttributes:dic];
    
    return size.width;
}



-(UILabel *)label2
{
    return objc_getAssociatedObject(self, label2Key);
}

-(void)setLabel2:(UILabel *)label2
{
    objc_setAssociatedObject(self, label2Key, label2, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)label1
{
    return objc_getAssociatedObject(self, label1Key);
}

-(void)setLabel1:(UILabel *)label1
{
    objc_setAssociatedObject(self, label1Key, label1, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(UITextField *)textField
{
    return objc_getAssociatedObject(self, textFieldKey);
}

-(void)setTextField:(UITextField *)textField
{
    objc_setAssociatedObject(self, textFieldKey, textField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(void)showMsgCountInTextMansory:(NSInteger)count cornerRadius:(CGFloat)cornerRadius
{
    UILabel *lab=[self viewWithTag:11336];
    [lab removeFromSuperview];
    
    CGSize sizeW=[self.titleLabel.text sizeWithAttributes:@{NSAttachmentAttributeName:self.titleLabel.font}];
    
    UILabel *labMsgCount=[[UILabel alloc]init];
    labMsgCount.layer.cornerRadius=cornerRadius/2;
    labMsgCount.clipsToBounds=YES;
    labMsgCount.backgroundColor=[UIColor redColor];
    labMsgCount.textColor=[UIColor whiteColor];
    labMsgCount.font=[UIFont systemFontOfSize:9];
    labMsgCount.textAlignment=NSTextAlignmentCenter;
    labMsgCount.text=count==0?@"":[NSString stringWithFormat:@"%zd", count];
    
    labMsgCount.tag=11336;
    [self addSubview:labMsgCount];
    //    [labMsgCount mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.mas_equalTo(self);
    //    }];
    [labMsgCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_right).offset(-cornerRadius-5);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-self.titleLabel.font.lineHeight/2);
        make.size.mas_equalTo(CGSizeMake(cornerRadius, cornerRadius));
    }];
    
}

-(void)showMsgCountInText:(NSInteger)count
{
    UILabel *lab=[self viewWithTag:11336];
    [lab removeFromSuperview];
    
    CGSize sizeW=[self.titleLabel.text sizeWithAttributes:@{NSAttachmentAttributeName:self.titleLabel.font}];
    
    UILabel *labMsgCount=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-(self.frame.size.width-sizeW.width)/2 , 5, 14, 14)];
    labMsgCount.layer.cornerRadius=labMsgCount.frame.size.width/2;
    labMsgCount.clipsToBounds=YES;
    labMsgCount.backgroundColor=[UIColor redColor];
    labMsgCount.textColor=[UIColor whiteColor];
    labMsgCount.font=[UIFont systemFontOfSize:9];
    labMsgCount.textAlignment=NSTextAlignmentCenter;
    labMsgCount.text=count==0?@"":[NSString stringWithFormat:@"%zd", count];
    if (count==0)
    {
        labMsgCount.hidden=YES;
    }
    labMsgCount.tag=11336;
    [self addSubview:labMsgCount];
}

-(void)showMsgCount:(NSInteger)count
{
    UILabel *labMsgCount=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-10 , -2, 16, 16)];
    labMsgCount.layer.cornerRadius=labMsgCount.frame.size.width/2;
    labMsgCount.clipsToBounds=YES;
    labMsgCount.backgroundColor=[UIColor greenColor];
    labMsgCount.textColor=[UIColor whiteColor];
    labMsgCount.font=[UIFont systemFontOfSize:10];
    labMsgCount.textAlignment=NSTextAlignmentCenter;
    labMsgCount.text=[NSString stringWithFormat:@"%zd", count];
    [self addSubview:labMsgCount];
}

-(void)showMsgCount:(NSInteger)count width:(CGFloat)width offset:(CGPoint)point
{
    UILabel *labMsgCount=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-point.x , point.y, width, width)];
    labMsgCount.layer.cornerRadius=labMsgCount.frame.size.width/2;
    labMsgCount.center = CGPointMake(self.frame.size.width-point.x, point.y);
    labMsgCount.clipsToBounds=YES;
    labMsgCount.backgroundColor=[UIColor redColor];
    labMsgCount.textColor=[UIColor whiteColor];
    labMsgCount.font=[UIFont systemFontOfSize:9];
    labMsgCount.textAlignment=NSTextAlignmentCenter;
    labMsgCount.text=[NSString stringWithFormat:@"%zd", count];
    [self addSubview:labMsgCount];
    
    if(count == 0)
    {
        labMsgCount.hidden = YES;
    }
}


-(UIViewController *)viewController
{
    return objc_getAssociatedObject(self, viewControllertKey);
}

-(void)setViewController:(UIViewController *)viewController
{
    objc_setAssociatedObject(self, viewControllertKey, viewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(void)setPoint:(CGPoint)point
{
    NSString *str=NSStringFromCGPoint(point);
    objc_setAssociatedObject(self, pointKey, str, OBJC_ASSOCIATION_COPY);
}

-(CGPoint)point
{
    NSString *str=objc_getAssociatedObject(self, pointKey);
    
    return CGPointFromString(str);
}

-(void)setIsClicked:(BOOL)isClicked
{
    NSNumber *number= [[NSNumber alloc] initWithInteger:isClicked];
    objc_setAssociatedObject(self, isClickedKey, number, OBJC_ASSOCIATION_COPY);
}

-(BOOL)isClicked
{
    return [objc_getAssociatedObject(self, isClickedKey) intValue];
}

-(void)setBtnClickState:(BtnClickState)btnClickState
{
    NSNumber *number= [[NSNumber alloc] initWithInteger:btnClickState];
    objc_setAssociatedObject(self, actNameKey, number, OBJC_ASSOCIATION_COPY);
    
}


-(CGFloat)floatPrice
{
    return [objc_getAssociatedObject(self, floatPriceKey) intValue];
}


-(void)setFloatPrice:(CGFloat)floatPrice
{
    NSNumber *number= [[NSNumber alloc] initWithInteger:floatPrice];
    objc_setAssociatedObject(self, floatPriceKey, number, OBJC_ASSOCIATION_COPY);
    
}



-(NSInteger)intCount
{
    return [objc_getAssociatedObject(self, intCountKey) intValue];
}


-(void)setIntCount:(NSInteger)intCount
{
    NSNumber *number= [[NSNumber alloc] initWithInteger:intCount];
    objc_setAssociatedObject(self, intCountKey, number, OBJC_ASSOCIATION_COPY);
    
}

-(BtnClickState)btnClickState
{
    return [objc_getAssociatedObject(self, actNameKey) intValue];
}

-(NSIndexPath *)indexPath
{
    return objc_getAssociatedObject(self, indexPathKey);
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    objc_setAssociatedObject(self, indexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSDictionary *)dicMsg
{
    return objc_getAssociatedObject(self, dicMsgKey);
}

-(void)setDicMsg:(NSDictionary *)dicMsg
{
    objc_setAssociatedObject(self, dicMsgKey, dicMsg, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(NSString *)strCatID
{
    return objc_getAssociatedObject(self, strCatIDKey);
}

-(void)setStrCatID:(NSString *)strCatID
{
    objc_setAssociatedObject(self, strCatIDKey, strCatID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(NSString *)strTypeName
{
    return objc_getAssociatedObject(self, strTypeNameKey);
}

-(void)setStrTypeName:(NSString *)strTypeName
{
    objc_setAssociatedObject(self, strTypeNameKey, strTypeName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(UILabel *)labName
{
    return objc_getAssociatedObject(self, labNameKey);
}

-(void)setLabName:(UILabel *)labName
{
    objc_setAssociatedObject(self, labNameKey, labName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setImgOrder:(UIImageView *)imgOrder
{
    objc_setAssociatedObject(self, imgOrderKey, imgOrder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)imgOrder
{
    return objc_getAssociatedObject(self, imgOrderKey);
}
@end
