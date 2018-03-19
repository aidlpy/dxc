//
//  WatingForPayCell.h
//  duxin
//
//  Created by 37duxin on 04/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagView.h"
#import "OrderModel.h"
#import "SubOrderModel.h"
#import "ConsultingMainModel.h"

typedef void(^CancelBlock)(NSInteger tag);
typedef void(^GeneralBlock)(NSInteger tag);
@interface WatingForPayCell : UITableViewCell
@property(nonatomic,retain)UILabel *titleLab;
@property(nonatomic,retain)UILabel *nameLab;
@property(nonatomic,retain)UILabel *orderTypeLab;
@property(nonatomic,retain)UIView  *lineView;
@property(nonatomic,retain)UIImageView  *headerImageView;
@property(nonatomic,retain)UILabel  *packageTitle;
@property(nonatomic,retain)UILabel  *packageCount;
@property(nonatomic,retain)UILabel  *packageDetail;
@property(nonatomic,retain)NSMutableArray *tagViewArray;
@property(nonatomic,retain)UILabel *packagePaymentLab;
@property(nonatomic,retain)UIButton *cancelOrderBtn;
@property(nonatomic,retain)UIButton *wiatingPayBtn;
@property(nonatomic,copy)CancelBlock cancelBlock;
@property(nonatomic,copy)GeneralBlock generalBlock;

-(void)setCellStytle:(NSInteger)cellStytleCode;
-(void)fetchData:(OrderModel *)model;
@end
