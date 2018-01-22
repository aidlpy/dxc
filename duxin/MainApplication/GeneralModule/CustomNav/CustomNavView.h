//
//  CustomNavView.h
//  HUAYI
//
//  Created by Albert on 7/19/16.
//  Copyright © 2016 zhan xingrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBtn.h"
typedef void(^backActionBlock)(void);
typedef void(^pushActionBlock)(void);

@interface CustomNavView : UIView
@property(nonatomic,retain)CustomBtn *middleBtn;
@property(nonatomic,retain) UIImageView *leftImaV;
@property(nonatomic,retain) CustomBtn *leftBtn;
@property(nonatomic,retain) CustomBtn *rightBtn;
@property(nonatomic,retain)UIView *lineView;
@property(nonatomic,copy)backActionBlock  backBlock;
@property(nonatomic,copy)pushActionBlock  pushBlock;
-(void)setMiddleTitle:(NSString *)title leftIma:(UIImage *)leftImg;
-(void)setBackStytle:(NSString *)title rightImage:(NSString *)rightImageStr;

@end
