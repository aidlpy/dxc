//
//  OrderModel.m
//  duxin
//
//  Created by 37duxin on 25/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+(NSArray *)fetchOrderModels:(NSArray *)itemsArray{
    
    NSMutableArray *pocketArray = [NSMutableArray new];
    [itemsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = (NSDictionary *)obj;
        
        OrderModel *model = [OrderModel new];
        model.orderId = [dic objectForKey:@"id"];
        model.orderUid = [dic objectForKey:@"uid"];
        model.orderCreatedAt = [dic objectForKey:@"created_at"];
        model.orderCid =  [dic objectForKey:@"cid"];
        model.orderStatus  =  [dic objectForKey:@"consultation_status"];
        model.orderReservationId = [dic objectForKey:@"reservation_order_id"];
        model.orderCsId = [dic objectForKey:@"cs_id"];
        model.orderPrice = [dic objectForKey:@"price"];
        model.orderType = [dic objectForKey:@"type"];
        model.orderStatus = [dic objectForKey:@"status"];
        model.packageId = [dic objectForKey:@"package_id"];
        model.orderIsReservation = [dic objectForKey:@"is_reservation"];
        model.orderIsInitiative  = [dic objectForKey:@"is_initiative"];
        
        NSDictionary *consultantProfileDic = [dic objectForKey:@"consultantProfile"];
        model.consultantName = [consultantProfileDic objectForKey:@"name"];
        model.consultantCid = [consultantProfileDic objectForKey:@"cid"];
        
        NSDictionary *packageDic = [dic objectForKey:@"package"];
        model.packageTitle = [packageDic objectForKey:@"title"];
        model.packageSerContent = [packageDic objectForKey:@"service_content"];
        model.packageSerTimes = [packageDic objectForKey:@"service_times"];
        model.packageSerHours = [packageDic objectForKey:@"service_hours"];
        model.packageSerType = [packageDic objectForKey:@"service_type"];
        model.packageSinglePrice = [packageDic objectForKey:@"single_price"];
        
        [pocketArray addObject:model];
        
    }];
    
    return pocketArray;
    
}


@end
