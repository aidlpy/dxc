//
//  CommentModel.h
//  duxin
//
//  Created by 37duxin on 28/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property(nonatomic,copy)NSString *commentConsultant;
@property(nonatomic,copy)NSString *commentEvaluationAt;
@property(nonatomic,copy)NSString *commentEvaluation;
@property(nonatomic,copy)NSString *commentFid;
@property(nonatomic,copy)NSString *commentIndex;
@property(nonatomic,copy)NSString *commentOrderNumber;
@property(nonatomic,copy)NSString *commentReply;
@property(nonatomic,copy)NSString *commentReplyAt;
@property(nonatomic,copy)NSString *commentStart;
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,assign)CGFloat footerHeight;

+(NSArray *)transferCommentModels:(NSArray *)array;
@end
