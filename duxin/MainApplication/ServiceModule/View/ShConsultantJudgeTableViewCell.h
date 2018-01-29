//
//  ShConsultantJudgeTableViewCell.h
//  duxin
//
//  Created by felix on 2018/1/27.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
#import "ShConsultantCommentDetailModel.h"

@interface ShConsultantJudgeTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *photoImageView;
@property (strong, nonatomic) UIImageView *sexImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) CWStarRateView *startNum;
@property (strong, nonatomic) UILabel *commentLabel;
@property (strong, nonatomic) UIView *line;

-(void)reloadUI:(ShConsultantCommentDetailModel *)commentModel;


@end
