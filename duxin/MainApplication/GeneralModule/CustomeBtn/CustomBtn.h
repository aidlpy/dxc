//
//  CustomBtn.h
//  HUAYI
//
//  Created by Albert on 4/5/16.
//  Copyright © 2016 zhan xingrong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^buttonAciton)(id sender);
typedef void(^photoShowBlock)(UIImage *image,UIImageView *displayImgV);

@interface CustomBtn : UIButton
@property(nonatomic,retain)NSString *btnState;
@property(nonatomic,retain)NSIndexPath *indexPath;
@property(nonatomic,retain)NSString *typestr;
@property(nonatomic,retain)UIButton *bgBtn;
@property(nonatomic,retain)UILabel *titleLab;
@property(nonatomic,retain)NSString *imgId;
@property(nonatomic,retain)UIImageView *displayImgV;
@property(nonatomic,copy)buttonAciton buttonBlock;
@property(nonatomic,copy)photoShowBlock photoShowBlock;
@property(nonatomic,retain)NSMutableArray *modelArr;
- (void)setCoverColor:(UIColor *)color;
-(void)setTitleLab:(NSString *)string;
-(void)setBackgroundColor:(UIColor *)backgroundColor state:(UIControlState)state;
-(void)setImage:(NSString *)str UIViewContentMode:(UIViewContentMode)contentModel;
-(void)setNewImage:(UIImage *)image UIViewContentMode:(UIViewContentMode)contentModel width:(float)w height:(float)h;
@end
