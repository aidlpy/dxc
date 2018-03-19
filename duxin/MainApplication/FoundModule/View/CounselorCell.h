//
//  CounselorCell.h
//  duxin
//
//  Created by 37duxin on 02/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounselorCell : UITableViewCell
@property(nonatomic,copy)UIImageView *headerImageView;
@property(nonatomic,copy)UILabel *titleLabel;
@property(nonatomic,copy)UILabel *areaLabel;
@property(nonatomic,retain)NSMutableArray *tagsArray;
@property(nonatomic,retain)NSMutableArray *detailsArray;
@end
