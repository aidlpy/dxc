//
//  SubOrderModel.m
//  duxin
//
//  Created by 37duxin on 27/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "SubOrderModel.h"

@implementation SubOrderModel
+(NSArray *)fetchOrderSubModels:(NSArray *)itemsArray{
    
    NSMutableArray *pocketArray = [NSMutableArray new];
    
    [itemsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = (NSDictionary *)obj;
        SubOrderModel *model = [SubOrderModel new];
        model.orderId = [dic objectForKey:@"id"];
        model.orderOId = [dic objectForKey:@"oid"];
        model.orderCId = [dic objectForKey:@"cid"];
        model.orderSubStatus = [dic objectForKey:@"sub_status"];
        model.orderOldPrice = [dic objectForKey:@"old_price"];
        model.orderPrice = [dic objectForKey:@"price"];
        model.orderSubOrderNumber = [dic objectForKey:@"sub_order_number"];
        
        //consultantProfile
        NSDictionary *consultantProfileDic = [dic objectForKey:@"consultantProfile"];
        model.consultantCid = [consultantProfileDic objectForKey:@"cid"];
        model.consultantName = [consultantProfileDic objectForKey:@"name"];
        
        //package
        NSDictionary *packageInfoDic = [dic objectForKey:@"packageInfo"];
        model.packageId = [packageInfoDic objectForKey:@"id"];
        model.packageTitle = [packageInfoDic objectForKey:@"title"];
        model.packageSerContent = [packageInfoDic objectForKey:@"service_content"];
        model.packageSerTimes = [packageInfoDic objectForKey:@"service_times"];
        model.packageSerHours = [packageInfoDic objectForKey:@"service_hours"];
        model.packageSerType = [packageInfoDic objectForKey:@"service_type"];
        model.packageSinglePrice = [packageInfoDic objectForKey:@"single_price"];
        NSString *tags = [packageInfoDic objectForKey:@"tags"];
        model.packageTags = [tags componentsSeparatedByString:@","];
        NSString *consultation_way_string = [packageInfoDic objectForKey:@"consultation_way"];
        model.packageConsultationWay = [consultation_way_string componentsSeparatedByString:@","];
        
        NSDictionary *userC = [dic objectForKey:@"userC"];
        if (userC) {
            model.emChatterAvatar = [userC objectForKey:@"avatar"];
            model.emChatterUserName = [userC objectForKey:@"emchart_username"];
        }
       
      
        
        [pocketArray addObject:model];
        
    }];

    return pocketArray;
    
}
@end
