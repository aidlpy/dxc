//
//  LoginView.h
//  duxin
//
//  Created by 37duxin on 20/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

typedef void(^fetchCodeBlock)(void);//发送验证码回调

@interface LoginView : UIView
@property(nonatomic,retain)UIImageView *logoImageView;
@property(nonatomic,retain)UITextField *textField;
@property(nonatomic,retain)UIButton *codeBtn;
@property(nonatomic,retain)UIView *lineView;
@property(nonatomic,copy)fetchCodeBlock codeBlock;


-(void)setLogoImageView:(NSString *)imageStr setPlaceHolder:(NSString *)placeHolder;

@end
