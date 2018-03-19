//
//  ShConstultTableViewCell.h
//  duxin
//
//  Created by felix on 2018/2/4.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShConsultModel.h"
@interface ShConstultTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *photoImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UIView *line;

-(void)reloadUI:(ShConsultModel *)model;


@end
