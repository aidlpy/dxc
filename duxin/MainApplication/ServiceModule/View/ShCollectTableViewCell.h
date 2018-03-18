//
//  ShCollectTableViewCell.h
//  duxin
//
//  Created by felix on 2018/1/31.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShCollectDetailModel.h"
#import "ShArticalModel.h"

@interface ShCollectTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *leftTitleLabel;
@property (strong, nonatomic) UILabel *LeftContentLabel;
@property (strong, nonatomic) UIImageView *photoImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *tagLabel;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic) UIImageView *eyeImagView;
@property (strong, nonatomic) UIButton *viewBtn;
@property (strong, nonatomic) UIView *line;


-(void)reloadUI:(ShCollectDetailModel *)model;
-(void)reloadUIWithArtical:(ShArticalModel *)model;

@end
