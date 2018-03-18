//
//  ConsultingMainModel.h
//  duxin
//
//  Created by 37duxin on 27/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "BaseOrderModel.h"

@interface ConsultingMainModel : BaseOrderModel
@property(nonatomic,copy)NSString *orderCid;//咨询师ID
@property(nonatomic,copy)NSString *orderCsId;//客服ID
@property(nonatomic,copy)NSString *orderUid;//C端用户ID
@property(nonatomic,copy)NSString *orderReservationId;//订单ID
@property(nonatomic,copy)NSString *orderStatus;//订单状态(0:待支付,1:待咨询,2:待评价,3:已评价,4:已完成,5:已关闭)
@property(nonatomic,copy)NSString *orderType;//订单类型(0:预约订单,1:咨询订单)
@property(nonatomic,copy)NSString *orderOldPrice;//原始价格
@property(nonatomic,copy)NSString *orderInfoCustomerDesc;//
@property(nonatomic,copy)NSString *orderConsultationStatus;

@property(nonatomic,copy)NSArray *packageConsultationWay;//咨询方式(0:电话,1:文字[多个用逗号分隔])
@property(nonatomic,copy)NSArray *packageTags;//标签[逗号分割]


@property(nonatomic,assign)BOOL orderIsReservation;//服务类型(0:预约服务,1:咨询服务)
@property(nonatomic,assign)BOOL orderIsInitiative;//是否C端用户主动下单(0:否,1:是) ,主动下单无cs_id(客服ID)

@property(nonatomic,copy)NSString *emChatterAvatar;
@property(nonatomic,copy)NSString *emChatterUserName;

@property(nonatomic,copy)NSString *orderInfoZXName;//
@property(nonatomic,copy)NSString *orderInfoZXGender;
@property(nonatomic,copy)NSString *orderInfoZXAge;
@property(nonatomic,copy)NSString *orderInfoZXProvince;
@property(nonatomic,copy)NSString *orderInfoZXCity;
@property(nonatomic,copy)NSString *orderInfoZXArea;

+(NSArray *)fetchConsultingMainModels:(NSArray *)itemsArray;

@end
