//
//  RegularTool.h
//  duxin
//
//  Created by 37duxin on 23/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^resultBlock)(NSString *res);
@interface RegularTool : NSObject



/*!
*  匹配3-15位的中文或英文(用户名)
*
*  @param username 需要匹配的字符串
*
*  @return 返回匹配结果
*/
+ (NSString *)matchUsername:(NSString *)username;


/*!
*  匹配6-18位的数字和字母组合(密码)
*
*  @param str 需要匹配的字符串
*
*  @return BOOl 返回匹配结果
 */
+(BOOL)matchPassword:(NSString *)str;

/*!
*  匹配邮箱帐号
*
*  @param email 需要匹配的邮箱帐号
*
*  @return 返回匹配结果
*/
+ (NSString *)matchEmail:(NSString *)email;

/*!
*  匹配身份证号码
*
*  @param idCard 需要匹配的身份证号码
*
*  @return 返回匹配结果
*/
+ (NSString *)matchUserIdCard:(NSString *)idCard;

/*!
*  匹配URL字符串
*
*  @param urlStr 需要匹配的URL字符串
*
*  @return 返回匹配结果
*/
+ (NSString *)matchURLStr:(NSString *)urlStr;

/*!
*  匹配¥:价格字符串
*
*  @param priceStr 包含价格的字符串
*
*  @return 返回匹配结果
*/
+ (BOOL)matchPriceStr:(NSString *)priceStr;

/*!
 *  验证码匹配
 *
 *  @param str 需要匹配的URL字符串
 *
 *  @return 返回匹配结果
 */
+(BOOL)matchCodeType:(NSString *)str;

@end
