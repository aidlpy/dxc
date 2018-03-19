//
//  EMFriendModel.m
//  duxin
//
//  Created by 37duxin on 01/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "EMFriendModel.h"

@implementation EMFriendModel
+(NSArray *)fetchFriendArray:(NSArray *)array{

    NSMutableArray *friendArray = [[NSMutableArray alloc] initWithCapacity:0];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dic = (NSDictionary *)obj;
        EMFriendModel *model = [[EMFriendModel alloc] init];
        
        model.emID = [dic objectForKey:@"id"];
        model.emUserID = [dic objectForKey:@"user_id"];
        model.emFriendID = [dic objectForKey:@"friend_id"];
        
        NSDictionary *friendDic = [dic objectForKey:@"friends"];
        model.emFriendsID = [friendDic objectForKey:@"id"];
        model.emFriendsNickname = [friendDic objectForKey:@"nickname"];
        
        if(![[friendDic objectForKey:@"avatar"] isEqual:[NSNull null]])
        {
            model.emFriendsAvatar = [friendDic objectForKey:@"avatar"];
        }
 
        NSString *emchatterId = [friendDic objectForKey:@"emchart_username"];
        if (![emchatterId isEqual:[NSNull null]]) {
            model.emFriendsChatUserName = emchatterId;
        }
        
        if (![emchatterId isEqual:[NSNull null]]) {
            EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:emchatterId type:EMConversationTypeChat createIfNotExist:YES];
            model.unreadMessageCount = [NSString stringWithFormat:@"%ld",(long)conversation.unreadMessagesCount];
            EMMessageBody *body = conversation.lastReceivedMessage.body;
            switch (body.type) {
                case EMMessageBodyTypeText:
                {
                    // 收到的文字消息
                    EMTextMessageBody *textBody = (EMTextMessageBody *)body;
                    model.lastMessage = textBody.text;
                }
                    break;
                case EMMessageBodyTypeImage:
                {
                    model.lastMessage = @"[图片]";
                }
                     break;
                case EMMessageBodyTypeVoice:
                {
                    model.lastMessage = @"[语音]";
                }
                    break;
                default:
                    break;
            }
        }
        
        NSString *createString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"created_at"]];
        if (![createString isEqual:[NSNull null]]) {
            model.emCreated_at = [createString timeWithTimeIntervalFullString];
        }
        
      
        
        [friendArray addObject:model];
    }];
    return friendArray;
    
}
@end
