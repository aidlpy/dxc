//
//  BaseOrderModel.h
//  duxin
//
//  Created by 37duxin on 27/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseOrderModel : NSObject
@property(nonatomic,copy)NSString *orderId;//索引ID
@property(nonatomic,copy)NSString *orderPrice;//订单金额

@property(nonatomic,copy)NSString *packageId;//套餐ID
@property(nonatomic,copy)NSString *packageTitle;//套餐名称
@property(nonatomic,copy)NSString *packageSerContent;//服务内容(描述)
@property(nonatomic,copy)NSString *packageSerTimes;//咨询次数
@property(nonatomic,copy)NSString *packageSerHours;//咨询时长(分钟)
@property(nonatomic,copy)NSString *packageSerType;//服务类型(0:预约服务,1:咨询服务)
@property(nonatomic,copy)NSString *packageSinglePrice;//单次价格(元)

@property(nonatomic,copy)NSString *consultantName;//咨询师名称
@property(nonatomic,copy)NSString *consultantCid;//咨询师ID

@end
