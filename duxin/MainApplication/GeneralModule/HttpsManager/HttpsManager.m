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
#define TEST_FORM_BOUNDARY @"BABABABABABBABA"

#define BMEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

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
    NSLog(@"dic==>%@api==>%@",dic,api);
    [manager POST:api parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==>%@",error);
        failBlock(error);
    } ];

}

- (void)postServerAPI:(NSString *)url photoData:(NSData *)data withDic:(NSMutableDictionary *)dic successful:(RequestSuccessfulBlock )successBlock fail:(RequestFailureBlock )failBlock {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [dic setObject:@"test" forKey:@"Upload[file]"];
    [dic setObject:@"1" forKey:@"type"];
    manager.requestSerializer.timeoutInterval =TIMEOUT;
    if (FetchToken != nil) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",FetchToken] forHTTPHeaderField:@"Authorization"];
    }
    [manager.requestSerializer setValue:@"form-data" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", nil];
    
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    
    
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}


-(void)postServerAPI:(NSString*)urlStr Paramater:(NSDictionary*)para data:(NSData*)data name:(NSString*)fileName andContentType:(NSString *)cotentype successful:(RequestSuccessfulBlock )successBlock fail:(RequestFailureBlock )failBlock
{
    
    NSMutableData *dataM = [NSMutableData data];
    
    /* 普通参数*/
    
    [para enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL *_Nonnull stop) {
        
        NSString *boundry = [NSString stringWithFormat:@"--%@\r\n",TEST_FORM_BOUNDARY];
        
        [dataM appendData:BMEncode(boundry)];
        
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n",key];
        
        NSLog(@"%@",disposition);
        
        [dataM appendData:BMEncode(disposition)];
        
        [dataM appendData:BMEncode(@"\r\n")];
        
        [dataM appendData:BMEncode(obj)];
        
        [dataM appendData:BMEncode(@"\r\n")];
        
    }];
    
    /* 普通参数*/
    
    /* 文件参数*/
    
    if(data&&data.length>0)
    {
        
        NSString *boundry = [NSString stringWithFormat:@"--%@\r\n",TEST_FORM_BOUNDARY];
        
        [dataM appendData:BMEncode(boundry)];
        
        NSString *disposition=[NSString stringWithFormat:@"Content-Disposition:form-data; name=\"Upload[file]\"; filename=\"%@\"\r\nContent-Type: %@\r\n\r\n",fileName,cotentype];
        
        NSLog(@"%@",disposition);
        
        [dataM appendData:BMEncode(disposition)];
        
        [dataM appendData:data];
        
        [dataM appendData:BMEncode(@"\r\n")];
        
    }
    
    /* 文件参数*/
    
    //尾部的分隔符
    
    NSString *strBottom = [NSString stringWithFormat:@"--%@--\r\n",TEST_FORM_BOUNDARY];
    
    [dataM appendData:BMEncode(strBottom)];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setValue:@"ZYB" forHTTPHeaderField:@"User-Agent"];

    [request setValue:@"max-age=7200" forHTTPHeaderField:@"Cache-Control"];
    
    //设置上传数据的长度及格式
    
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",TEST_FORM_BOUNDARY] forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)dataM.length] forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:dataM];
    
    //创建会话
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionUploadTask *updataTask = [session uploadTaskWithRequest:request fromData:dataM completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError * _Nullable error) {
        
        if (!error) {
    
            NSLog(@"photoresponse:%@",response);
            
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSString dictionaryWithJsonString:dataStr];
           
            successBlock(dic);
            NSLog(@"dataStr:%@",dataStr);
            
        }else{
            failBlock(error);
            NSLog(@"error:%@",error);
        }
        
    }];
    
    [updataTask resume];
    
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
