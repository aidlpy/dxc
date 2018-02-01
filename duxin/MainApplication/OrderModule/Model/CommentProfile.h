//
//  CommentProfile.h
//  duxin
//
//  Created by 37duxin on 30/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentProfile : NSObject
@property(nonatomic,copy)NSArray *tags;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *avatar;
+(CommentProfile *)fetchModelsArray:(NSDictionary *)dic;
@end
