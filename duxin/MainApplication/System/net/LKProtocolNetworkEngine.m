//
//	 ______    ______    ______
//	/\  __ \  /\  ___\  /\  ___\
//	\ \  __<  \ \  __\_ \ \  __\_
//	 \ \_____\ \ \_____\ \ \_____\
//	  \/_____/  \/_____/  \/_____/
//
//
//	Copyright (c) 2015-2016, quncaotech
//	http://www.quncaotech.com
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a
//	copy of this software and associated documentation files (the "Software"),
//	to deal in the Software without restriction, including without limitation
//	the rights to use, copy, modify, merge, publish, distribute, sublicense,
//	and/or sell copies of the Software, and to permit persons to whom the
//	Software is furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//	IN THE SOFTWARE.
//

#import "LKProtocolNetworkEngine.h"
#import "LKProtocolNetworkOperation.h"
#import "LKFilePath.h"
//#import "LMUtilities.h"

static NSString* lk_prefix_url = nil;

@implementation LKProtocolNetworkEngine

IMPLEMENT_SINGLETON(LKProtocolNetworkEngine);

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
- (void) protocolWithUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler
{
    [self protocolWithUrl:url requestModel:requestModel responseModelCls:responseModelCls useCache:YES completionHandler:completionHandler];
}

- (void) protocolWithUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler
{
    [self protocolWithUrl:url requestDictionary:requestDict responseModelCls:responseModelCls useCache:NO completionHandler:completionHandler];
}

- (void) protocolWithUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler
{
    [self protocolWithUrl:url requestDictionary:requestModel.keyValues responseModelCls:responseModelCls useCache:useCache completionHandler:completionHandler];
}

- (void) protocolWithUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler
{
    [self protocolWithUrl:url requestDictionary:requestModel.keyValues responseModelCls:responseModelCls useCache:useCache forceReload:forceReload completionHandler:completionHandler];
}

//两层结构模式
- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler {
    
    [self protocolWithRequestMethod:method requestUrl:url requestDictionary:requestModel.keyValues responseModelCls:responseModelCls useCache:NO forceReload:YES  completionHandler:completionHandler];

}

- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler
{
    [self protocolWithRequestMethod:method requestUrl:url requestDictionary:requestModel.keyValues responseModelCls:responseModelCls useCache:useCache forceReload:forceReload completionHandler:completionHandler];
}

- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls  completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler
{
    [self protocolWithRequestMethod:method requestUrl:url requestDictionary:requestDict responseModelCls:responseModelCls useCache:NO completionHandler:completionHandler];
    
}

//两层结构模式
- (void) protocolWithUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache  completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler {
    
    [self protocolWithUrl:url requestDictionary:requestDict responseModelCls:responseModelCls useCache:useCache forceReload:YES completionHandler:completionHandler];
}


- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache  completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler {
    [self protocolWithRequestMethod:method requestUrl:url requestDictionary:requestDict responseModelCls:responseModelCls useCache:useCache forceReload:YES completionHandler:completionHandler];
}


- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler  {
    NSString *allURL;
    
    if (![url hasPrefix:@"http"]) {
        allURL =[NSString stringWithFormat:@"%@%@",lk_prefix_url,url];
    }
    else {
        allURL = [NSString stringWithFormat:@"%@",url];;
    }
    
    NSLog(@"xlz requestDict = %@",requestDict);
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
            completionHandler(nil,nil,nil)
            ;return ;
        }
        
        
//        if (model.statusCode != 200) {
//            completionHandler(model,nil);
//            return ;
//        }
//
//        if (responseModelCls) {
//            if ([model.data isKindOfClass:[NSDictionary class]]) {
//                model.data = [responseModelCls objectWithKeyValues:model.data];
//            }
//            else if ([model isKindOfClass:[NSArray class]]) {
//                model.data = [responseModelCls objectArrayWithKeyValuesArray:model.data];
//            }
//        }
        
        SHModel *shModel;
        
        if (model.code != 200) {
            completionHandler(model,shModel,nil);
            return ;
        }
        
        if ([model.data isKindOfClass:[NSDictionary class]]) {
            shModel = [SHModel objectWithKeyValues:model.data];
        }
        else if ([model isKindOfClass:[NSArray class]]) {
            shModel = [SHModel objectArrayWithKeyValuesArray:model.data];
        }
        
        if (responseModelCls) {
            if ([shModel.result isKindOfClass:[NSDictionary class]]) {
                shModel.result = [responseModelCls objectWithKeyValues:shModel.result];
            }
            else if ([shModel.result isKindOfClass:[NSArray class]]) {
                shModel.result = [responseModelCls objectArrayWithKeyValuesArray:shModel.result];
            }
        }
        
        completionHandler(model,shModel,nil);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        completionHandler(nil,nil,error);
    }];
    [self enqueueOperation:op forceReload:forceReload];
}

- (void) protocolWithUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler {
    
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
        NSLog(@"responseString = %@",completedOperation.responseString);
        
        if (model) {
            model.isCache = NO;
            if (completedOperation.isCachedResponse) {
                model.isCache = YES;
            }
        }
        if (model == nil)  {
            completionHandler(nil,nil,nil);
            return ;
        }
        
        SHModel *shModel;
        
        if (model.code != 200) {
            completionHandler(model,shModel,nil);
            return ;
        }
        
        if ([model.data isKindOfClass:[NSDictionary class]]) {
            shModel = [SHModel objectWithKeyValues:model.data];
        }
        else if ([model isKindOfClass:[NSArray class]]) {
            shModel = [SHModel objectArrayWithKeyValuesArray:model.data];
        }
        
        if (responseModelCls) {
            if ([shModel.result isKindOfClass:[NSDictionary class]]) {
                shModel.result = [responseModelCls objectWithKeyValues:shModel.result];
            }
            else if ([shModel.result isKindOfClass:[NSArray class]]) {
                shModel.result = [responseModelCls objectArrayWithKeyValuesArray:shModel.result];
            }
        }
        NSLog(@"shModel error_code = %zd",shModel.error_code);
        completionHandler(model,shModel,nil);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        completionHandler(nil,nil,error);
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
