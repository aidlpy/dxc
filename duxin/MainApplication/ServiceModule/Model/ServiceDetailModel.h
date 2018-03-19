//
//  ServiceDetailModel.h
//  duxin
//
//  Created by 37duxin on 03/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceDetailModel : NSObject
@property(nonatomic,copy)NSString *serviceId;
@property(nonatomic,copy)NSString *servieTitle;
@property(nonatomic,copy)NSString *serviceContent;
@property(nonatomic,copy)NSString *serviceTimes;
@property(nonatomic,copy)NSString *serviceHours;
@property(nonatomic,copy)NSString *serviceType;
@property(nonatomic,copy)NSString *serviceSinglePrice;
@property(nonatomic,assign)CGFloat cellHeight;
+(void)dic:(NSDictionary *)dic model:(void(^)(ServiceDetailModel *model))modelBlock;
@end
