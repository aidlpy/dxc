//
//  MyConselorCell.h
//  duxin
//
//  Created by 37duxin on 19/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface MyConselorCell : UITableViewCell
@property(nonatomic,retain)UIImageView *headerImageView;
@property(nonatomic,retain)UILabel *titleLab;
@property(nonatomic,retain)UIImageView *rightArrow;
@property(nonatomic,retain)UIView *lineView;

-(void)setDefaultStytle;
@end
