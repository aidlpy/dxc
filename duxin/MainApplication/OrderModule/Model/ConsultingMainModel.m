//
//  ConsultingMainModel.m
//  duxin
//
//  Created by 37duxin on 27/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ConsultingMainModel.h"

@implementation ConsultingMainModel
+(NSArray *)fetchConsultingMainModels:(NSArray *)itemsArray{
    
    NSMutableArray *pocketArray = [NSMutableArray new];
    
    [itemsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = (NSDictionary *)obj;
        ConsultingMainModel *model = [ConsultingMainModel new];
        model.orderId = [dic objectForKey:@"id"];
        model.orderCid = [dic objectForKey:@"cid"];
        model.orderStatus = [dic objectForKey:@"status"];
        model.orderOldPrice = [dic objectForKey:@"old_price"];
        model.orderPrice = [dic objectForKey:@"price"];
        model.orderReservationId = [dic objectForKey:@"reservation_order_id"];
        
        //consultantProfile
        NSDictionary *consultantProfileDic = [dic objectForKey:@"consultantProfile"];
        model.consultantCid = [consultantProfileDic objectForKey:@"cid"];
        model.consultantName = [consultantProfileDic objectForKey:@"name"];
        
        //package
        NSDictionary *packageInfoDic = [dic objectForKey:@"package"];
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
        
        [pocketArray addObject:model];
        
    }];
    
    return pocketArray;
    
}
@end
