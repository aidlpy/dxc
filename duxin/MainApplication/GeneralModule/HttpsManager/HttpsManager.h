//
//  HttpsManager.h
//  Albert
//
//  Created by Albert on 3/27/17.
//  Copyright © 2017 smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Reachability.h"
#import "Header.h"



////test
#define GET_URL(API) [NSString stringWithFormat:@"http://api.uat.37du.xin%@",API]
#define POST_URL(API) [NSString stringWithFormat:@"http://api.uat.37du.xin%@",API]


#define FetchLogin POST_URL(@"/oauth2/token")
#define FetchUserInfo GET_URL(@"/v1/user/get-user")
#define PostRegister POST_URL(@"/v1/user/sign")
#define PostMobileCode POST_URL(@"/v1/common/verification")
#define PostMobileCodeForPS POST_URL(@"/v1/user/rest-password")
#define PostReigsteredMobileCode POST_URL(@"/v1/common/get-code")
#define PostMobileCodeForPSUnLogin POST_URL(@"/v1/user/modify-password")
#define FetchReservationOrders GET_URL( @"/v1/trade/reservation-item")
#define PostCancelOrder POST_URL(@"/v1/trade/cancel-order/")
#define PostDeleteOrder POST_URL(@"/v1/trade/delete-main/")
#define FetchConsultingOrders GET_URL(@"/v1/trade/consultation-item")
#define FetchConsultingSubOrders GET_URL(@"/v1/consultation/sub-item")
#define FetchOrderComments GET_URL(@"/v1/consultation/query-consultation-evaluation/")
#define FetchConsultinProfile GET_URL(@"/v1/consultation/user-profile/")
#define postReservationComment POST_URL(@"/v1/reservation/active-evaluation/")
#define postConsultingComment POST_URL(@"/v1/consultation/active-evaluation/")
#define postImageURL POST_URL(@"/v1/file/avatar")
#define postModifyPersonalInfo POST_URL(@"/v1/user/basic-save")
#define FetchMyConsultingList GET_URL(@"/v1/user/my-follow")
#define PostModifyMobileNumber POST_URL(@"/v1/user/modify-username")

//SH
#define FetchConsultantInfo  GET_URL(@"/v1/user/psychologist-homepage/")//咨询师详情
#define FetchConsultantComment  GET_URL(@"/v1/user/home-reviews/1")//评论
#define FetchConsultantMyFollow  GET_URL(@"/v1/user/my-follow") //我关注的咨询师
#define FetchFollowConsultant  GET_URL(@"/v1/user/follow/") //关注咨询师
#define FetchUnFollowConsultant  GET_URL(@"/v1/user/un-follow/") //取消关注咨询师
#define FetchUnFollowConsultant  GET_URL(@"/v1/magazine/my-collection") //获取我收藏的文章列表





typedef void (^RequestSuccessfulBlock)(id responseObject);
typedef void (^RequestFailureBlock)(id error);

@interface HttpsManager : NSObject

-(void)getServerAPI:(NSString *)api deliveryDic:(NSMutableDictionary *)dic successful:(RequestSuccessfulBlock)successBlock fail:(RequestFailureBlock)failBlock;
-(void)postServerAPI:(NSString *)api deliveryDic:(NSMutableDictionary *)dic successful:(RequestSuccessfulBlock)successBlock fail:(RequestFailureBlock)failBlock;
-(NSString *)deviceIPAdress;
-(void)postServerAPI:(NSString*)urlStr Paramater:(NSDictionary*)para data:(NSData*)data name:(NSString*)fileName andContentType:(NSString *)cotentype successful:(RequestSuccessfulBlock )successBlock fail:(RequestFailureBlock )failBlock;
@end
