//
//  SubOrderModel.h
//  duxin
//
//  Created by 37duxin on 27/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "BaseOrderModel.h"

@interface SubOrderModel : BaseOrderModel
@property(nonatomic,copy)NSString *orderOId;//咨询父订单ID
@property(nonatomic,copy)NSString *orderCId;//来访者ID(用户ID)
@property(nonatomic,copy)NSString *orderSubStatus;//订单状态(0:待咨询,1:待评价,2:已评价)
@property(nonatomic,copy)NSString *orderOldPrice;//原始价格
@property(nonatomic,copy)NSString *orderSubOrderNumber;//子订单号

@property(nonatomic,copy)NSArray *packageConsultationWay;//咨询方式(0:电话,1:文字[多个用逗号分隔])
@property(nonatomic,copy)NSArray *packageTags;//标签[逗号分割]

@property(nonatomic,copy)NSString *orderInfoId;//订单信息
@property(nonatomic,copy)NSString *orderInfoCustomerDesc;//
@property(nonatomic,copy)NSString *orderInfoZXName;//
@property(nonatomic,copy)NSString *orderInfoZXGender;
@property(nonatomic,copy)NSString *orderInfoZXAge;
@property(nonatomic,copy)NSString *orderInfoZXProvince;
@property(nonatomic,copy)NSString *orderInfoZXCity;
@property(nonatomic,copy)NSString *orderInfoZXArea;
@property(nonatomic,copy)NSString *orderInfoReservationOrderId;

+(NSArray *)fetchOrderSubModels:(NSArray *)itemsArray;

@end
