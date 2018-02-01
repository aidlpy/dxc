//
//  ShProtocolNetworkEngine.h
//  duxin
//
//  Created by felix on 2018/2/1.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "MKNetworkEngine.h"
#import "LKSingleton.h"
#import "LMModel.h"
#import "SHModel.h"
#import "MJExtension.h"

@interface ShProtocolNetworkEngine : MKNetworkEngine
DECLARE_SINGLETON(ShProtocolNetworkEngine);

+ (void) setPrefixURL:(NSString*) url ;

- (void) protocolWithUrl:(NSString *)url requestModel:(NSObject *) request responseModelCls:(Class) responseModelCls completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler;
- (void) protocolWithUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler;
- (void) protocolWithUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler;
- (void) protocolWithUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler;
- (void) protocolWithUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler;
- (void) protocolWithUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler;

- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler;
- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls  completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler;
- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler;
- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache  completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler;
- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,NSError* error)) completionHandler;
@end

