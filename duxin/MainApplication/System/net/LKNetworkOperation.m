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

#import "LKNetworkOperation.h"
#import "NSObject+Runtime.h"
#import "NSUserDefaults+SafeAccess.h"


static char kNSInputStreamLarkKey;

@interface NSInputStream (LARK)

- (NSInteger)swizzle_read:(uint8_t *)buffer maxLength:(NSUInteger)len;
- (BOOL)swizzle_getBuffer:(uint8_t * __nullable * __nonnull)buffer length:(NSUInteger *)len;
- (NSMutableData *)getRemainData;
- (void)setRemainData:(NSMutableData *)data;
@end


@implementation NSInputStream (LARK)

- (NSMutableData *)getRemainData {
    return (NSMutableData *)objc_getAssociatedObject(self, &kNSInputStreamLarkKey);
}
- (void)setRemainData:(NSMutableData *)data {
    objc_setAssociatedObject(self, &kNSInputStreamLarkKey, data, OBJC_ASSOCIATION_RETAIN);
}

- (NSInteger)swizzle_read:(uint8_t *)buffer maxLength:(NSUInteger)len {
    NSInteger readSize = [self swizzle_read:buffer maxLength:len];
    [[self getRemainData] appendBytes:buffer length:readSize];
    return readSize;
}
- (BOOL)swizzle_getBuffer:(uint8_t * __nullable * __nonnull)buffer length:(NSUInteger *)len {
    return  [self swizzle_getBuffer:buffer length:len];
}
@end




@interface LKNetworkOperation()
@property NSDictionary<NSString *, NSString *>  *debugRequestHeads;
@property NSMutableData                         *debugRequestBody;
@property NSDictionary<NSString *, NSString *>  *debugResponseHeads;
@property NSMutableData                         *debugResponseBody;
@property NSInteger                              debugStatusCode;
@property NSURL                                 *debugRequestUrl;
@property NSURL                                 *debugRequestMainDocumentURL;
@end

@implementation LKNetworkOperation

+ (NSString *)descriptionForHTTPStatus:(NSUInteger)status {    
    NSString *description = nil;
    // http://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml
    if(status == 100) description = @"Continue";
    else if(status == 101) description = @"Switching Protocols";
    else if(status == 102) description = @"Processing";
    else if(status == 200) description = @"OK";
    else if(status == 201) description = @"Created";
    else if(status == 202) description = @"Accepted";
    else if(status == 203) description = @"Non-Authoritative Information";
    else if(status == 204) description = @"No Content";
    else if(status == 205) description = @"Reset Content";
    else if(status == 206) description = @"Partial Content";
    else if(status == 207) description = @"Multi-Status";
    else if(status == 208) description = @"Already Reported";
    else if(status == 223) description = @"IM Used";
    else if(status == 300) description = @"Multiple Choices";
    else if(status == 301) description = @"Moved Permanently";
    else if(status == 302) description = @"Found";
    else if(status == 303) description = @"See Other";
    else if(status == 304) description = @"Not Modified";
    else if(status == 305) description = @"Use Proxy";
    else if(status == 307) description = @"Temporary Redirect";
    else if(status == 308) description = @"Permanent Redirect";
    else if(status == 400) description = @"Bad Request";
    else if(status == 401) description = @"Unauthorized";
    else if(status == 402) description = @"Payment Required";
    else if(status == 403) description = @"Forbidden";
    else if(status == 404) description = @"Not Found";
    else if(status == 405) description = @"Method Not Allowed";
    else if(status == 406) description = @"Not Acceptable";
    else if(status == 407) description = @"Proxy Authentication Required";
    else if(status == 408) description = @"Request Timeout";
    else if(status == 409) description = @"Conflict";
    else if(status == 410) description = @"Gone";
    else if(status == 411) description = @"Length Required";
    else if(status == 412) description = @"Precondition Failed";
    else if(status == 413) description = @"Payload Too Large";
    else if(status == 414) description = @"URI Too Long";
    else if(status == 415) description = @"Unsupported Media Type";
    else if(status == 416) description = @"Requested Range Not Satisfiable";
    else if(status == 417) description = @"Expectation Failed";
    else if(status == 422) description = @"Unprocessable Entity";
    else if(status == 423) description = @"Locked";
    else if(status == 424) description = @"Failed Dependency";
    else if(status == 425) description = @"Unassigned";
    else if(status == 426) description = @"Upgrade Required";
    else if(status == 427) description = @"Unassigned";
    else if(status == 428) description = @"Precondition Required";
    else if(status == 429) description = @"Too Many Requests";
    else if(status == 430) description = @"Unassigned";
    else if(status == 431) description = @"Request Header Fields Too Large";
    else if(status == 432) description = @"Unassigned";
    else if(status == 500) description = @"Internal Server Error";
    else if(status == 501) description = @"Not Implemented";
    else if(status == 502) description = @"Bad Gateway";
    else if(status == 503) description = @"Service Unavailable";
    else if(status == 504) description = @"Gateway Timeout";
    else if(status == 505) description = @"HTTP Version Not Supported";
    else if(status == 506) description = @"Variant Also Negotiates";
    else if(status == 507) description = @"Insufficient Storage";
    else if(status == 508) description = @"Loop Detected";
    else if(status == 509) description = @"Unassigned";
    else if(status == 510) description = @"Not Extended";
    else if(status == 511) description = @"Network Authentication Required";
    
    return description;
}

- (NSString *)debugDescription {
    NSMutableString *ms = [NSMutableString string];
    NSString *method = self.HTTPMethod;
    [ms appendFormat:@"\r\n\r\n%@ %@", method, [self url]];
    NSDictionary *headers = self.debugRequestHeads;
    if([headers count]) [ms appendString:@"\r\n"];
    [headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [ms appendFormat:@"%@: %@\r\n", key, obj];
    }];
    if (self.debugRequestBody!=nil && [self.debugRequestBody length]>0) {
        [ms appendString:@"\r\n"];
        [ms appendString:[[NSString alloc] initWithData:self.debugRequestBody encoding:NSUTF8StringEncoding]];
    }
    [ms appendString:@"\r\n\r\n\r\n"];
    //RESPONSE
    [ms appendFormat:@"HTTP/1.1 %ld %@",(long)self.debugStatusCode,[LKNetworkOperation descriptionForHTTPStatus:self.debugStatusCode]];
    headers = self.debugResponseHeads;
    if([headers count]) [ms appendString:@"\r\n"];
    [headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [ms appendFormat:@"%@: %@\r\n", key, obj];
    }];
    if (self.debugResponseBody!=nil && [self.debugResponseBody length]>0) {
        [ms appendString:@"\r\n"];
        NSString *bodyString =[[NSString alloc] initWithData:self.debugResponseBody encoding:NSUTF8StringEncoding];
        [ms appendString:bodyString];
    }
    return ms;
}

- (NSString *)makeCookieValueOfHeaderByCookies:(NSArray *)cookies{
    NSString *cookieHeader = nil;
    @synchronized(self){
        if ([cookies count] > 0) {
            NSHTTPCookie *cookie;
            for (cookie in cookies) {
                if (!cookieHeader) {
                    cookieHeader = [NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]];
                } else{
                    cookieHeader = [NSString stringWithFormat: @"%@; %@=%@",cookieHeader,[cookie name],[cookie value]];
                }
            }
        }
    }
    return cookieHeader;
}
-(void)saveCookie {
    NSArray *cookieArray = [NSHTTPCookie cookiesWithResponseHeaderFields:self.debugResponseHeads forURL:self.debugRequestUrl];
    if ([cookieArray count] == 0) return;
    NSString *cookieHeader = nil;
    NSHTTPCookie *cookie;
    for (cookie in cookieArray) {
        if (!cookieHeader) {
            cookieHeader = [NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]];
        } else {
            cookieHeader = [NSString stringWithFormat: @"%@; %@=%@",cookieHeader,[cookie name],[cookie value]];
        }
    }
    if (cookieHeader!=nil) [NSUserDefaults setObject:cookieHeader forKey:@"LARK_SAVECOOKIE"];
}
-(NSString*)loadCookie {
    return [NSUserDefaults stringForKey:@"LARK_SAVECOOKIE"];
}

- (nullable NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(nullable NSURLResponse *)response {
    self.debugRequestUrl =[request URL];
    self.debugRequestMainDocumentURL = [request mainDocumentURL];
    NSMutableURLRequest * req = (NSMutableURLRequest*)[super connection:connection willSendRequest:request redirectResponse:response];
    
    //load cookie
    NSString* cookieStr =[self loadCookie];
    if (cookieStr!=nil) [req setValue: cookieStr forHTTPHeaderField: @"Cookie"];
    
    self.debugRequestBody   =[[NSMutableData alloc] init];
    self.debugRequestHeads  =nil;
    self.debugResponseBody  =[[NSMutableData alloc] init];
    self.debugResponseHeads =nil;
    self.debugRequestHeads = [[req allHTTPHeaderFields] mutableCopy];
    if (req.HTTPBodyStream!=nil) {
        [[req.HTTPBodyStream class] swizzleMethod:@selector(read:maxLength:) withMethod:@selector(swizzle_read:maxLength:)];
        [[req.HTTPBodyStream class] swizzleMethod:@selector(getBuffer:length:) withMethod:@selector(swizzle_getBuffer:length:)];
        [req.HTTPBodyStream setRemainData:self.debugRequestBody];
    }
    else if (req.HTTPBody!=nil) {
        self.debugRequestBody = (NSMutableData *)req.HTTPBody;
    }
    return req;
    

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [super connection:connection didReceiveResponse:response];
    self.debugResponseHeads = [[(NSHTTPURLResponse*)response allHeaderFields] mutableCopy];
    self.debugStatusCode  =((NSHTTPURLResponse*)response).statusCode;
    [self saveCookie];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [super connection:connection didReceiveData:data];
    [self.debugResponseBody appendData:data];
}

- (instancetype)initWithURLString:(NSString *)aURLString
                           params:(NSDictionary *)params
                       httpMethod:(NSString *)method {
    
    self = [super initWithURLString:aURLString params:params httpMethod:method];
    if (self) {
        self.freezable = FALSE;
    }
    return self;
}


-(BOOL) isCacheable {
    if(self.shouldNotCacheResponse) return NO;
    if(self.clientCertificate != nil) return NO;
    if(self.clientCertificatePassword != nil) return NO;
    return YES;
}
@end
