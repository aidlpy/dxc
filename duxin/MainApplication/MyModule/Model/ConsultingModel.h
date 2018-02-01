//
//  ConsultingModel.h
//  duxin
//
//  Created by 37duxin on 31/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsultingModel : NSObject
@property(nonatomic,retain)NSString *toUserid;
@property(nonatomic,retain)NSString *avatar;
@property(nonatomic,retain)NSString *name;

+(NSArray *)fetchFoucsModel:(NSArray *)foucesArray;
@end
