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
  
        if (![[modelDic objectForKey:@"fid"] isEqual:[NSNull null]]){
            model.commentFid = [modelDic objectForKey:@"fid"];
        }
        
        model.commentOrderNumber = [modelDic objectForKey:@"order_number"];

        if (![[modelDic objectForKey:@"reply"] isEqual:[NSNull null]]) {
            model.commentReply = [modelDic objectForKey:@"reply"];
        }
        if (![[modelDic objectForKey:@"reply_at"] isEqual:[NSNull null]]){
            model.commentReplyAt = [modelDic objectForKey:@"reply_at"];
        }
      

        
        model.commentStart = [modelDic objectForKey:@"start"];
        model.commentAvatar = [modelDic objectForKey:@"avatar"];
        [pocketArray addObject:model];
        
    }];
    
    return  pocketArray;
    
    
}

+(NSArray *)transferAllCommentModels:(NSArray *)array{
    
    
    NSMutableArray *pocketArray = [[NSMutableArray alloc] initWithCapacity:0];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *modelDic = (NSDictionary *)obj;
        CommentModel *model = [[CommentModel alloc] init];
        //  model.commentConsultant = [modelDic objectForKey:@"consultant"];
        model.commentEvaluation = [modelDic objectForKey:@"evaluation"];
        model.commentEvaluationAt = [modelDic objectForKey:@"evaluation_at"];
        
        if (![[modelDic objectForKey:@"fid"] isEqual:[NSNull null]]){
            model.commentFid = [modelDic objectForKey:@"fid"];
        }
        
        NSString *index = [[modelDic objectForKey:@"sort"] objectForKey:@"index"];
        model.commentIndex = [NSString stringWithFormat:@"%@",index];
        model.commentOrderNumber = [modelDic objectForKey:@"order_number"];
        
        if (![[modelDic objectForKey:@"reply"] isEqual:[NSNull null]]) {
            model.commentReply = [modelDic objectForKey:@"reply"];
        }
        if (![[modelDic objectForKey:@"reply_at"] isEqual:[NSNull null]]){
            model.commentReplyAt = [modelDic objectForKey:@"reply_at"];
        }
        

        model.commentStart = [modelDic objectForKey:@"start"];
        model.commentAvatar = [[modelDic objectForKey:@"profileAvatar"] objectForKey:@"avatar"];
        [pocketArray addObject:model];
        
    }];
    
    return  pocketArray;
    
    
}

@end
