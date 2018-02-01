//
//  CommentProfile.m
//  duxin
//
//  Created by 37duxin on 30/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "CommentProfile.h"

@implementation CommentProfile

+(CommentProfile *)fetchModelsArray:(NSDictionary *)dic
{
    CommentProfile *model = [[CommentProfile alloc] init];
    NSString *tagsString = [dic objectForKey:@"tags"];
    model.tags = [tagsString componentsSeparatedByString:@","];
    model.name = [dic objectForKey:@"name"];
    model.avatar = [dic objectForKey:@"avatar"];
    
    return model;
}

@end
