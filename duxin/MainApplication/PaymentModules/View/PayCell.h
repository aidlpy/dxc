//
//  PayCell.h
//  duxin
//
//  Created by 37duxin on 02/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayCell : UITableViewCell
@property(nonatomic,retain)UIImageView *headerImageView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIImageView *selectedImageView;
@property(nonatomic,retain)UIView *lineView;
-(void)upDateUI:(NSDictionary *)dic;
@end
