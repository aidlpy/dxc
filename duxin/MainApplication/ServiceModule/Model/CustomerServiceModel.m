//
//  CustomerServiceModel.m
//  duxin
//
//  Created by 37duxin on 01/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "CustomerServiceModel.h"

@implementation CustomerServiceModel
+(void)fetchModelsFromArray:(NSArray *)array fetchModel:(void (^)(BOOL isStop,CustomerServiceModel *model))fetchModelBlock{

    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",[NSThread currentThread]);
            NSDictionary *dic = (NSDictionary *)obj;
            CustomerServiceModel *model = [[CustomerServiceModel alloc] init];
            model.consultantProfileCID = [dic objectForKey:@"cid"];
            model.consultantProfileStatus = [dic objectForKey:@"status"];
            model.consultantProfileUID = [dic objectForKey:@"uid"];
            NSDictionary *consultantProfileDic = [dic objectForKey:@"consultantProfile"];
            model.consultantProfileName = [consultantProfileDic objectForKey:@"name"];
            NSDictionary *userAvatarDic = [dic objectForKey:@"userAvatar"];
            model.consultantProfileAvatar = [userAvatarDic objectForKey:@"avatar"];
            fetchModelBlock(stop,model);
    }];
}
@end
