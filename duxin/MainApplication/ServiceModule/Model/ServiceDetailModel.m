//
//  ServiceDetailModel.m
//  duxin
//
//  Created by 37duxin on 03/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ServiceDetailModel.h"



@implementation ServiceDetailModel

-(instancetype)init{
    self = [super init];
    if (self) {
        _cellHeight = 50;
    }
    return self;
}

+(void)dic:(NSDictionary *)dic model:(void(^)(ServiceDetailModel *model))modelBlock{

        ServiceDetailModel *model = [ServiceDetailModel new];
        model.serviceId = [dic objectForKey:@"id"];
        model.servieTitle = [dic objectForKey:@"title"];
        model.serviceContent = [dic objectForKey:@"service_content"];
        model.serviceTimes = [dic objectForKey:@"service_times"];
        model.serviceHours = [dic objectForKey:@"service_hours"];
        model.serviceType = [dic objectForKey:@"service_type"];
        model.serviceSinglePrice= [dic objectForKey:@"single_price"];
        modelBlock(model);

}
@end
