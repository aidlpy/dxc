//
//  CustomerServiceModel.h
//  duxin
//
//  Created by 37duxin on 01/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerServiceModel : NSObject
@property(nonatomic,copy)NSString *consultantProfileID;
@property(nonatomic,copy)NSString *consultantProfileCID;
@property(nonatomic,copy)NSString *consultantProfileName;
@property(nonatomic,copy)NSString *consultantProfileStatus;
@property(nonatomic,copy)NSString *consultantProfileUID;
@property(nonatomic,copy)NSString *consultantProfileAvatar;

+(void)fetchModelsFromArray:(NSArray *)array fetchModel:(void (^)(BOOL isStop,CustomerServiceModel *model))fetchModelBlock;
@end
