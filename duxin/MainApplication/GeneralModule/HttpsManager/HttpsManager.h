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
#define FetchReservationOrders GET_URL(@"/v1/trade/reservation-item")
#define PostCancelOrder POST_URL(@"/v1/trade/cancel-order/")
#define PostDeleteOrder POST_URL(@"/v1/trade/delete-main/")
#define FetchConsultingOrders GET_URL(@"/v1/trade/consultation-item")
#define FetchConsultingSubOrders GET_URL(@"/v1/consultation/sub-item")
#define FetchOrderComments GET_URL(@"/v1/consultation/query-consultation-evaluation/")


typedef void (^RequestSuccessfulBlock)(id responseObject);
typedef void (^RequestFailureBlock)(id error);

@interface HttpsManager : NSObject

-(void)getServerAPI:(NSString *)api deliveryDic:(NSMutableDictionary *)dic successful:(RequestSuccessfulBlock)successBlock fail:(RequestFailureBlock)failBlock;
-(void)postServerAPI:(NSString *)api deliveryDic:(NSMutableDictionary *)dic successful:(RequestSuccessfulBlock)successBlock fail:(RequestFailureBlock)failBlock;
-(NSString *)deviceIPAdress;
@end
