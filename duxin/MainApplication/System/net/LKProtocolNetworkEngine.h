//
//     ______    ______    ______
//    /\  __ \  /\  ___\  /\  ___\
//    \ \  __<  \ \  __\_ \ \  __\_
//     \ \_____\ \ \_____\ \ \_____\
//      \/_____/  \/_____/  \/_____/
//
//
//    Copyright (c) 2015-2016, quncaotech
//    http://www.quncaotech.com
//
//
//    Permission is hereby granted, free of charge, to any person obtaining a
//    copy of this software and associated documentation files (the "Software"),
//    to deal in the Software without restriction, including without limitation
//    the rights to use, copy, modify, merge, publish, distribute, sublicense,
//    and/or sell copies of the Software, and to permit persons to whom the
//    Software is furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in
//    all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//    IN THE SOFTWARE.
//

#import "LKPrecompile.h"
#import "MKNetworkEngine.h"
#import "LKSingleton.h"
#import "LMModel.h"
#import "SHModel.h"
#import "MJExtension.h"

@interface LKProtocolNetworkEngine : MKNetworkEngine
DECLARE_SINGLETON(LKProtocolNetworkEngine);

+ (void) setPrefixURL:(NSString*) url ;

- (void) protocolWithUrl:(NSString *)url requestModel:(NSObject *) request responseModelCls:(Class) responseModelCls completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler;
- (void) protocolWithUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler;
- (void) protocolWithUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler;
- (void) protocolWithUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler;
- (void) protocolWithUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler;
- (void) protocolWithUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler;

- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler;
- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls  completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler;
- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestModel:(NSObject *) requestModel responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler;
- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache  completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler;
- (void) protocolWithRequestMethod:(NSString *)method requestUrl:(NSString *)url requestDictionary:(NSDictionary *) requestDict responseModelCls:(Class) responseModelCls useCache:(BOOL)useCache forceReload:(BOOL)forceReload completionHandler:(void (^)(LMModel * response,SHModel *responseC,NSError* error)) completionHandler;
@end

