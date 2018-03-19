//
//  EMFriendModel.h
//  duxin
//
//  Created by 37duxin on 01/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMFriendModel : NSObject
@property(nonatomic,copy)NSString *emID;
@property(nonatomic,copy)NSString *emUserID;
@property(nonatomic,copy)NSString *emFriendID;
@property(nonatomic,copy)NSString *emFriendsChatUserName;
@property(nonatomic,copy)NSString *emFriendsAvatar;
@property(nonatomic,copy)NSString *emFriendsNickname;
@property(nonatomic,copy)NSString *emFriendsID;
@property(nonatomic,copy)NSString *emCreated_at;
@property(nonatomic,copy)NSString *lastMessage;
@property(nonatomic,copy)NSString *unreadMessageCount;
+(NSArray *)fetchFriendArray:(NSArray *)array;
@end
