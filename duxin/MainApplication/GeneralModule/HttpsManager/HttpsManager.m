//
//  HttpsManager.m
//  球汉
//
//  Created by 洋洋钟 on 3/27/17.
//  Copyright © 2017 smith. All rights reserved.
//

#import "HttpsManager.h"
#import "IPAdress.h"

#define TIMEOUT 60 //请求超时时间

@implementation HttpsManager
-(void)getServerAPI:(NSString *)api deliveryDic:(NSMutableDictionary *)dic successful:(RequestSuccessfulBlock )successBlock fail:(RequestFailureBlock )failBlock
{
   
    NSMutableDictionary  *dicc = [self getBaseMsg:dic];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval =TIMEOUT;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    if (FetchToken != nil) {
         [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",FetchToken] forHTTPHeaderField:@"Authorization"];
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", nil];
    NSLog(@"getDicc==>%@URL===>%@",dicc,api);
    
    [manager GET:api parameters:dicc progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject==>%@",responseObject);
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==>%@",error);
        failBlock(error);
    }];
    
}

-(void)postServerAPI:(NSString *)api deliveryDic:(NSMutableDictionary *)dic successful:(RequestSuccessfulBlock )successBlock fail:(RequestFailureBlock )failBlock
{
    [dic addEntriesFromDictionary:[self getBaseMsg:dic]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval =TIMEOUT;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    if (FetchToken != nil) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",FetchToken] forHTTPHeaderField:@"Authorization"];
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", nil];
    NSLog(@"dic==>%@",dic);
    [manager POST:api parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==>%@",error);
        failBlock(error);
    } ];

}

-(NSMutableDictionary *)getBaseMsg:(NSMutableDictionary *)dic
{
   
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user  objectForKey:@"deviceid"])
    {
        [dic setObject:[user objectForKey:@"deviceid"] forKey:@"deviceid"];
    }
    NSString *string = FetchToken;
    if (string != nil ) {
        NSString *auth = [NSString stringWithFormat:@"%@ %@",FetchTokenType,FetchToken];
        [dic setObject:auth forKey:@"Authorization"];
    }
    return dic;
}


-(NSString *)appendHeaderStr:(NSArray *)sortedKeys andDic:(NSMutableDictionary *)dic
{
    NSString *headerStr =[[NSString alloc] init];
    int i;
    for (i = 0; i<dic.count; i++) {
        if (i<=3) {
            NSString *str = [[NSString alloc] init];
            str = [sortedKeys[i] stringByAppendingString:[dic objectForKey:sortedKeys[i]]];
            headerStr = [headerStr stringByAppendingString:str];
        }
      
    }
    return headerStr;
}

-(NSString *)appendFooterStr:(NSArray *)sortedKeys
{
    NSString *str = [[NSString alloc] init];
    int i ;
    if (sortedKeys.count <=4) {
        
        for (i = 0; i<sortedKeys.count; i++) {
            str = [str stringByAppendingString:sortedKeys[i]];
        }
        
    }
    else
    {
        for ( i = 0; i <4; i++) {
            str = [str stringByAppendingString:sortedKeys[i]];
        }
        
        
    }
    
    return str;
    
}


-(NSString *)requestFailReason:(NSString *)error
{
    if ([self connectedToNetwork])
    {
        if ([error isEqualToString:@"请求超时。"])
        {
           
        }
        else
        {
           
        }
        return @"网络连接失败!";
    }
    else
    {
        return @"服务器或者网络错误！";
    }
}

- (NSString *)deviceIPAdress{
    InitAddresses();
    GetIPAddresses();
    GetHWAddresses();
    return [NSString stringWithFormat:@"%s", ip_names[1]];
}



// 判断网络是否可以连接
-(BOOL) connectedToNetwork
{
    Reachability *rea=[Reachability reachabilityForInternetConnection];
    return rea.currentReachabilityStatus==NotReachable?NO:YES;
}


@end
