//
//  ServiceDetailCell.h
//  duxin
//
//  Created by 37duxin on 03/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDetailModel.h"

@interface ServiceDetailCell : UITableViewCell
@property(nonatomic,retain)UITextView *textView;
@property(nonatomic,retain)UILabel *label;
-(void)updateUI:(ServiceDetailModel *)model;
@end
