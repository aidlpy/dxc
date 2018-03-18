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
#define GET_URL(API) [NSString stringWithFormat:@"https://api.37du.xin%@",API]
#define POST_URL(API) [NSString stringWithFormat:@"https://api.37du.xin%@",API]


#define FetchLogin POST_URL(@"/oauth2/token")
#define FetchUserInfo GET_URL(@"/v1/user/get-user")
#define PostRegister POST_URL(@"/v1/user/sign")
#define PostMobileCode POST_URL(@"/v1/common/verification")
#define PostMobileCodeForPS POST_URL(@"/v1/user/rest-password")
#define PostReigsteredMobileCode POST_URL(@"/v1/common/get-code")
#define PostMobileCodeForPSLogin POST_URL(@"/v1/user/modify-password")
#define FetchReservationOrders GET_URL( @"/v1/trade/reservation-item")
#define PostCancelOrder POST_URL(@"/v1/trade/cancel-order/")
#define PostDeleteOrder POST_URL(@"/v1/trade/delete-main/")
#define FetchConsultingList GET_URL( @"/v1/user/query-consultant-lists")
#define FetchConsultingOrders GET_URL(@"/v1/trade/consultation-item")
#define FetchConsultingSubOrders GET_URL(@"/v1/consultation/sub-item")
#define FetchOrderComments GET_URL(@"/v1/consultation/query-consultation-evaluation/")
#define FetchReOrderComments GET_URL(@"/v1/reservation/query-reservation-evaluation/")
#define FetchAllOrderComment GET_URL(@"/v1/consultation/all-consultation-evaluation/")

#define FetchConsultinProfile GET_URL(@"/v1/consultation/user-profile/")
#define postReservationComment POST_URL(@"/v1/reservation/active-evaluation/")
#define postConsultingComment POST_URL(@"/v1/consultation/active-evaluation/")
#define postImageURL POST_URL(@"/v1/file/avatar")
#define postModifyPersonalInfo POST_URL(@"/v1/user/basic-save")
#define FetchMyConsultingList GET_URL(@"/v1/user/my-follow")
#define PostModifyMobileNumber POST_URL(@"/v1/user/modify-username")
#define PostEMMessageToServer POST_URL(@"/v1/emchat/app-callback")
#define PostForPaymentCode POST_URL(@"/v1/unity/pay")
#define FetchPackageBSingle GET_URL(@"/v1/package/view-package/")
#define FetchCreateOrderNumber GET_URL(@"/v1/reservation/initiative-create")
#define FetchPaymentSuccessdfully GET_URL(@"/v1/unity/union-pay-query")
#define FetchMyCollection GET_URL(@"/v1/magazine/my-collection")



//EM
#define FetchEMFriends GET_URL(@"/v1/emchat/findfriends")
#define FetchEMFriendsRelation POST_URL(@"/v1/emchat/getstatus")


//SH
#define FetchConsultantInfo  GET_URL(@"/v1/user/psychologist-homepage/")//咨询师详情
#define FetchConsultantComment  GET_URL(@"/v1/user/home-reviews/")//评论
#define FetchConsultantMyFollow  GET_URL(@"/v1/user/my-follow") //我关注的咨询师
#define FetchFollowConsultant  GET_URL(@"/v1/user/follow/") //关注咨询师
#define FetchUnFollowConsultant  GET_URL(@"/v1/user/un-follow/") //取消关注咨询师
#define FetchUnFollowCollection  GET_URL(@"/v1/magazine/my-collection") //获取我收藏的文章列表
#define FetchConsultant  GET_URL(@"/v1/consultant?expand=user") //获取咨询师检索信息
#define FetchMagazine  GET_URL(@"/v1/magazine?expand=user") //获取文章列表
#define FetchConsultingList GET_URL( @"/v1/user/query-consultant-lists")//关注过的咨询师



typedef void (^RequestSuccessfulBlock)(id responseObject);
typedef void (^RequestFailureBlock)(id error);

@interface HttpsManager : NSObject

-(void)getServerAPI:(NSString *)api deliveryDic:(NSMutableDictionary *)dic successful:(RequestSuccessfulBlock)successBlock fail:(RequestFailureBlock)failBlock;
-(void)postServerAPI:(NSString *)api deliveryDic:(NSMutableDictionary *)dic successful:(RequestSuccessfulBlock)successBlock fail:(RequestFailureBlock)failBlock;
-(NSString *)deviceIPAdress;
-(void)postServerAPI:(NSString*)urlStr Paramater:(NSDictionary*)para data:(NSData*)data name:(NSString*)fileName andContentType:(NSString *)cotentype successful:(RequestSuccessfulBlock )successBlock fail:(RequestFailureBlock )failBlock;
@end
