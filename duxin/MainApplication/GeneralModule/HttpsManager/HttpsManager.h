//
//  HttpsManager.h
//  球汉
//
//  Created by 洋洋钟 on 3/27/17.
//  Copyright © 2017 smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Reachability.h"
#import "Header.h"



////test
#define GET_URL(API) [NSString stringWithFormat:@"http://api.uat.37du.xin/%@",API]
#define POST_URL(API) [NSString stringWithFormat:@"http://api.uat.37du.xin%@",API]


#define FetchLogin POST_URL(@"/oauth2/token")

#define FetchRegister GET_URL(@"/admin/register.json")
#define UpdateInfoAPI GET_URL(@"/admin/update_userinfo.json")
#define ALLitemsAPI GET_URL(@"/items/listall.json")
#define FetchitemsOfCategoryId GET_URL(@"/item/getall.json")
#define FetchCollectionItemsList GET_URL(@"/collection/collection_add.json")
#define FetchCommentList GET_URL(@"/review/detail_list.json")
#define FetchAddressList GET_URL(@"/adr/showall.json")
#define UpdateDefaultAdddress GET_URL(@"/adr/upd_type.json")
#define UploadAddtionalAddressAPI GET_URL(@"/adr/add.json")
#define DelAddressAPI GET_URL(@"/adr/del_adr.json")
#define SearchItemsList GET_URL(@"/search/showall.json")
#define OrderAddAPI GET_URL(@"/order/add.json")


#define FetchOrderInfo GET_URL(@"/secure/buy.json")
#define FetchInsuranceList GET_URL(@"/insurance/list.json")
#define GETALIPAY GET_URL(@"/secure/getAlipay.json")
#define FetchNewsList GET_URL(@"/news/limitall.json")
#define FetchResultNewsList GET_URL(@"/news/listlike.json")
#define SubmitNews GET_URL(@"/user/addtg.json")

#define FetchArticleList GET_URL(@"/user/contribute.json")
#define UpdatePersonalInfo GET_URL(@"/springUpload.json")
#define FetchMessageList GET_URL(@"/message/byid.json")

typedef void (^RequestSuccessfulBlock)(id responseObject);
typedef void (^RequestFailureBlock)(id error);

@interface HttpsManager : NSObject

-(void)getServerAPI:(NSString *)api deliveryDic:(NSMutableDictionary *)dic successful:(RequestSuccessfulBlock)successBlock fail:(RequestFailureBlock)failBlock;
-(void)postServerAPI:(NSString *)api deliveryDic:(NSMutableDictionary *)dic successful:(RequestSuccessfulBlock)successBlock fail:(RequestFailureBlock)failBlock;
-(NSString *)deviceIPAdress;
@end
