//
//  ConsultingModel.m
//  duxin
//
//  Created by 37duxin on 31/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ConsultingModel.h"

@implementation ConsultingModel
+(NSArray *)fetchFoucsModel:(NSArray *)foucesArray
{
    
    NSMutableArray *pocketArray = [[NSMutableArray alloc] init];
    [foucesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        ConsultingModel *model = [ConsultingModel new];
        model.toUserid = [dic objectForKey:@"to_user_id"];
        model.name = [dic objectForKey:@"name"];
        model.avatar = [dic objectForKey:@"avatar"];
        [pocketArray addObject:model];
    }];
    return pocketArray;
}
@end
