//
//  ShConsultantDetailTableViewCell.h
//  duxin
//
//  Created by felix on 2018/1/25.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShConsultantPackageModel.h"

@interface ShConsultantDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *leftLabel;
@property (strong, nonatomic) UILabel *rightLabel;
@property (strong, nonatomic) UIView *line;

-(void)reloadUI:(ShConsultantPackageModel *)packageModel;

@end
