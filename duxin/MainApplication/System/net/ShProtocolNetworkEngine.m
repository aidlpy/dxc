//
//  ShProtocolNetworkEngine.m
//  duxin
//
//  Created by felix on 2018/2/1.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import "ShProtocolNetworkEngine.h"
#import "LKProtocolNetworkOperation.h"
#import "LKFilePath.h"
//#import "LMUtilities.h"

static NSString* lk_prefix_url = nil;

@implementation ShProtocolNetworkEngine
IMPLEMENT_SINGLETON(ShProtocolNetworkEngine);

+ (void) setPrefixURL:(NSString*) url {
    lk_prefix_url =url;
}

- (id) init {
    NSMutableDictionary * customHeaders = [[NSMutableDictionary alloc] initWithCapacity:6];
    customHeaders[@"Accept"]=@"application/json";
    customHeaders[@"Accept-Encoding"]=@"gzip, deflate, sdch";
    customHeaders[@"Accept-Language"]=@"zh-CN,zh;q=0.8";
    customHeaders[@"Connection"]=@"keep-alive";
    customHeaders[@"Accept-Charset"]=@"UTF-8";
    customHeaders[@"Authorization"]=[NSString stringWithFormat:@"%@ %@",FetchTokenType,FetchToken];;

    NSLog(@"customHeaders===>%@",customHeaders);
    //    if ([LMUtilities isLogin]) {
    //        customHeaders[@"X-Token"]= [LMUtilities getToken];
    //    }
    //    @"c652b3dc01ebc3830dec16bd45c17cfd";
    
    
    self=[super initWithHostName:@"" customHeaderFields:customHeaders];
    if (self) {
        [self registerOperationSubclass:[LKProtocolNetworkOperation class]];
        [self useCache];
    }
    return self;
}

/***
 *关于返回的LKModel
 *  如果responseData中data是一个字典，则传入的responseModelCls便是由该字典所转换的模型，返回的LKModel.data为该模型
 *  如果responseData中data是一个数组，则传入的responseModelCls便是数组中的每个字典元素所转换的模型，返回的LKModel.data为该模型的数组
 */
- (void) protocolWithUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler
{
    [self protocolWithUrl:url requestModel:requestModel responseModelCls:responseModelCls useCache:YES completionHandler:completionHandler];
}

- (void) protocolWithUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler
{
    [self protocolWithUrl:url requestDictionary:requestDict responseModelCls:responseModelCls useCache:NO completionHandler:completionHandler];
}

- (void) protocolWithUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler
{
    [self protocolWithUrl:url requestDictionary:requestModel.keyValues responseModelCls:responseModelCls useCache:useCache completionHandler:completionHandler];
}

- (void) protocolWithUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler
{
    [self protocolWithUrl:url requestDictionary:requestModel.keyValues responseModelCls:responseModelCls useCache:useCache forceReload:forceReload completionHandler:completionHandler];
}

- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler {
    [self protocolWithRequestMethod:method requestUrl:url requestDictionary:requestModel.keyValues responseModelCls:responseModelCls useCache:NO forceReload:YES completionHandler:completionHandler];
}

- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler
{
    [self protocolWithRequestMethod:method requestUrl:url requestDictionary:requestModel.keyValues responseModelCls:responseModelCls useCache:useCache forceReload:forceReload completionHandler:completionHandler];
}

- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls  completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler
{
    [self protocolWithRequestMethod:method requestUrl:url requestDictionary:requestDict responseModelCls:responseModelCls useCache:NO completionHandler:completionHandler];
}

- (void) protocolWithUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache  completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler {
    
    [self protocolWithUrl:url requestDictionary:requestDict responseModelCls:responseModelCls useCache:useCache forceReload:YES completionHandler:completionHandler];
}

- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache  completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler {
    [self protocolWithRequestMethod:method requestUrl:url requestDictionary:requestDict responseModelCls:responseModelCls useCache:useCache forceReload:YES completionHandler:completionHandler];
}



- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler  {
    NSString *allURL;
    
    if (![url hasPrefix:@"http"]) {
        allURL =[NSString stringWithFormat:@"%@%@",lk_prefix_url,url];
    }
    else {
        allURL = [NSString stringWithFormat:@"%@",url];;
    }
    
    NSLog(@"xlz requestDict = %@ ulr==>%@",requestDict,url);
    MKNetworkOperation *op = [self operationWithURLString:allURL params:requestDict httpMethod:method];
    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    op.shouldNotCacheResponse = !useCache;
   
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
#ifdef DEBUG
        
        NSLog(@"\r\n\r\n----------------------------START----------------------------\r\n\r\n");
        NSLog(@"%@",[completedOperation debugDescription]);
        NSLog(@"%@",completedOperation.responseString);
        NSLog(@"\r\n\r\n----------------------------END----------------------------\r\n\r\n");
#else
#endif
        LMModel *model = [LMModel objectWithKeyValues:completedOperation.responseString];
        if (model) {
            model.isCache=NO;
            if (completedOperation.isCachedResponse) {
                model.isCache=YES;
            }
        }
        if (model == nil)  {
            completionHandler(nil,nil);return ;
        }
        if (model.code != 200) {
            completionHandler(model,nil);
            return ;
        }
        
        if (responseModelCls) {
            if ([model.data isKindOfClass:[NSDictionary class]]) {
                model.data = [responseModelCls objectWithKeyValues:model.data];
            }
            else if ([model isKindOfClass:[NSArray class]]) {
                model.data = [responseModelCls objectArrayWithKeyValuesArray:model.data];
            }
        }
        
        completionHandler(model,nil);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        completionHandler(nil,error);
    }];
    [self enqueueOperation:op forceReload:forceReload];
}

- (void) protocolWithUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler {
    
    NSString *allURL;
    NSString *method = @"GET";
    
    //    if (!requestDict)
    //        method = ;
    //    else
    //        method = @"POST";
    if (![url hasPrefix:@"http"]) {
        allURL = [NSString stringWithFormat:@"%@%@",lk_prefix_url,url];
    }
    else {
        allURL = [NSString stringWithFormat:@"%@",url];;
    }
    NSLog(@"allURL = %@",allURL);
    MKNetworkOperation *op = [self operationWithURLString:allURL params:requestDict httpMethod:method];
    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    op.shouldNotCacheResponse = !useCache;
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
#ifdef DEBUG
        
        NSLog(@"\r\n\r\n----------------------------START----------------------------\r\n\r\n");
        NSLog(@"%@",[completedOperation debugDescription]);
        NSLog(@"%@",completedOperation.responseString);
        NSLog(@"\r\n\r\n----------------------------END----------------------------\r\n\r\n");
#else
#endif
        
        LMModel *model = [LMModel objectWithKeyValues:completedOperation.responseString];
        if (model) {
            model.isCache = NO;
            if (completedOperation.isCachedResponse) {
                model.isCache = YES;
            }
        }
        if (model == nil)  {
            completionHandler(nil,nil);
            return ;
        }
        if (model.code != 200) {
            completionHandler(model,nil);
            return ;
        }
        
        if (responseModelCls) {
            if ([model.data isKindOfClass:[NSDictionary class]]) {
                model.data = [responseModelCls objectWithKeyValues:model.data];
            }
            else if ([model isKindOfClass:[NSArray class]]) {
                model.data = [responseModelCls objectArrayWithKeyValuesArray:model.data];
            }
        }
        completionHandler(model,nil);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        completionHandler(nil,error);
    }];
    [self enqueueOperation:op forceReload:forceReload];
}

-(NSString*) cacheDirectoryName {
    return [LKFilePath getProtocolCachePath];
}

-(int) cacheMemoryCost {
    return  16;
}

@end
