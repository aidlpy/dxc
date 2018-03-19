//
//  ShArticalModel.m
//  duxin
//
//  Created by felix on 2018/2/7.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import "ShArticalModel.h"

@implementation ShArticalModel
+(void)fetchData:(NSArray *)array block:(void(^)(BOOL stop,ShArticalModel *model))fetchModelBlock{
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"obj==>%@",obj);
        ShArticalModel *model = [ShArticalModel new];
        model.briefly = [obj objectForKey:@"briefly"];
        model.banner = [obj objectForKey:@"banner"];
        NSNumber * collection  = [obj objectForKey:@"collection"] ;
        model.collection = collection.integerValue;
        model.content = [obj objectForKey:@"content"];
        model.head_figure = [obj objectForKey:@"head_figure"];
        NSNumber *articalid = [obj objectForKey:@"id"];
        model.id = articalid.integerValue;
        NSNumber *likes = [obj objectForKey:@"likes"];
        model.title = [obj objectForKey:@"title"];
        model.likes = likes.integerValue;
        model.page_description = [obj objectForKey:@"page_description"];
        model.page_title = [obj objectForKey:@"page_title"];
        model.preview_text = [obj objectForKey:@"page_title"];
        NSNumber *timeNumber = [obj objectForKey:@"publish_time"];
        model.publish_time = timeNumber.integerValue;
        NSNumber *articalType = [obj objectForKey:@"type"];
        model.type =articalType.integerValue;
        NSNumber *uid = [obj objectForKey:@"uid"];
        model.uid = uid.integerValue;
        NSNumber *views = [obj objectForKey:@"views"];
        model.views = views.integerValue;
     
        if ([obj objectForKey:@"user"]) {
            model.user = [ShUserModel new];
            NSDictionary *userDic = [obj objectForKey:@"user"];
            NSNumber *userid = [userDic objectForKey:@"id"];
            model.user.id = userid.integerValue;
            model.user.avatar = [userDic objectForKey:@"avatar"];
            model.user.nickname = [userDic objectForKey:@"nickname"];
            NSNumber *genderNumber = [userDic objectForKey:@"gender"];
            model.user.gender = genderNumber.integerValue;
            
        }
        
        if (fetchModelBlock) {
            fetchModelBlock(stop,model);
        }
        
    }];

}
@end
