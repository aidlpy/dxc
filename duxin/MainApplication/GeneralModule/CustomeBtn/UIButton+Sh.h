//
//  UIButton+Sh.h
//  LeeMall
//
//  Created by 沈宗琪 on 2017/3/16.
//  Copyright © 2017年 MaxWellPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Sh)
typedef NS_ENUM(NSInteger, BtnClickState) {
    BtnClickStateNO = 3,//
    BtnClickStateDesc =1,//降序
    BtnClickStateAsc=0 ,//升序
    
};

typedef NS_ENUM(NSUInteger, UIButtonEdgeInsetsStyle) {
    UIButtonEdgeInsetsStyleTop, // image在上，label在下
    UIButtonEdgeInsetsStyleLeft, // image在左，label在右
    UIButtonEdgeInsetsStyleBottom, // image在下，label在上
    UIButtonEdgeInsetsStyleRight // image在右，label在左
};

@property(nonatomic,retain)UIViewController *viewController;
@property(nonatomic,retain)NSDictionary *dicMsg;
@property(nonatomic,retain)UITextField *textField;
@property(nonatomic,retain)NSIndexPath *indexPath;
@property(nonatomic,retain)UIImageView *imgOrder;
@property(nonatomic,retain)UILabel *labName;
@property(nonatomic,retain)UILabel *label1;
@property(nonatomic,retain)UILabel *label2;
@property(nonatomic,assign)BtnClickState btnClickState;
@property(nonatomic,assign)BOOL isClicked;
@property(nonatomic,retain)NSString *strCatID;
@property(nonatomic,retain)NSString *strTypeName;
@property(nonatomic,assign)NSInteger intCount;
@property(nonatomic,assign)CGFloat floatPrice;
@property(nonatomic,assign)CGPoint point;

- (CGFloat)sizeWidth;
- (void)showMsgCountMansory:(NSInteger)count width:(CGFloat)width offset:(CGPoint)point;
- (void)showMsgCount:(NSInteger)count;
- (void)showMsgCount:(NSInteger)count width:(CGFloat)width offset:(CGPoint)point;
- (void)showMsgCountInText:(NSInteger)count;
- (void)setImage:(NSString *)strImageURL forState:(UIControlState)controlStateNormal placeHolderImage:(UIImage *)placeHolderImage;
- (void)showMsgCountInTextMansory:(NSInteger)count cornerRadius:(CGFloat)cornerRadius;
/*
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(UIButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
@end
