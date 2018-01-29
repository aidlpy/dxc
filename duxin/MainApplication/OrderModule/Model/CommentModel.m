//
//  CommentModel.m
//  duxin
//
//  Created by 37duxin on 28/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
-(instancetype)init{
    self =[super init];
    if (self) {
        _cellHeight = 120.0f;
        _footerHeight = 0.001f;
    }
    return self;
}

+(NSArray *)transferCommentModels:(NSArray *)array{
    
    
    NSMutableArray *pocketArray = [[NSMutableArray alloc] initWithCapacity:0];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *modelDic = (NSDictionary *)obj;
        CommentModel *model = [[CommentModel alloc] init];
        model.commentConsultant = [modelDic objectForKey:@"consultant"];
        model.commentEvaluation = [modelDic objectForKey:@"evaluation"];
        model.commentEvaluationAt = [modelDic objectForKey:@"evaluation_at"];
        model.commentFid = [modelDic objectForKey:@"fid"];
        model.commentIndex = [modelDic objectForKey:@"index"];
        model.commentOrderNumber = [modelDic objectForKey:@"order_number"];

        if (![[modelDic objectForKey:@"reply"] isEqualToString:@""]) {
           model.commentReply = [modelDic objectForKey:@"reply"];
            NSLog(@"model.commentReply==>%@",model.commentReply);
        }
        model.commentReplyAt = [modelDic objectForKey:@"reply_at"];
        model.commentStart = [modelDic objectForKey:@"start"];
        model.commentAvatar = [modelDic objectForKey:@"avatar"];
        [pocketArray addObject:model];
        
    }];
    
    return  pocketArray;
    
    
}

@end
