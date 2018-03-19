//
//  RegularTool.m
//  duxin
//
//  Created by 37duxin on 23/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "RegularTool.h"

@implementation RegularTool

#pragma mark - 匹配固定电话号码



+(BOOL)matchCodeType:(NSString *)str {
    BOOL result = false;
    if ([str length] >= 6){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^[0-9]{0,6}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:str];
    }
    return result;
}


#pragma mark - 匹配3-15位的中文或英文(用户名)
+(NSString *)matchUsername:(NSString *)username {
    NSString *pattern = @"^[a-zA-Z一-龥]{3,15}$";
    __block NSString *result;
    [RegularTool matchString:username withPattern:pattern resultBlock:^(NSString *res) {
        result = res;
    }];
    return result;
}

#pragma mark - 匹配6-16位的数字和字母组合(密码)
+(BOOL)matchPassword:(NSString *)str {
    BOOL result = false;
    if ([str length] >= 6){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:str];
    }
    return result;
}

#pragma mark - 匹配邮箱帐号
+ (NSString *)matchEmail:(NSString *)email {
    NSString *pattern =@"^[a-z0-9]+([\\._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+\\.){1,63}[a-z0-9]+$";
    __block NSString *result;
    [RegularTool matchString:email withPattern:pattern resultBlock:^(NSString *res) {
        result = res;
    }];
    return result;
}


#pragma mark - 匹配身份证号码
+(NSString *)matchUserIdCard:(NSString *)idCard {
    NSString *pattern =@"(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)";
    __block NSString *result;
    [RegularTool matchString:idCard withPattern:pattern resultBlock:^(NSString *res) {
        result = res;
    }];
    return result;
}

#pragma mark - 匹配URL字符串
+(NSString *)matchURLStr:(NSString *)urlStr {
    NSString *pattern = @"^[0-9A-Za-z]{1,50}$";
    __block NSString *result;
    [RegularTool matchString:urlStr withPattern: pattern resultBlock:^(NSString *res) {
        result = res;
    }];
    return result;
}

#pragma mark - 匹配¥:价格字符串
+(BOOL)matchPriceStr:(NSString *)priceStr {
    NSError *error = nil;
    NSString *pattern = @"¥(\\d+(?:\\.\\d+)?)";
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options: 1 << 0 error: &error];
    if (!error) {
            NSArray<NSTextCheckingResult *> *result = [regular matchesInString:priceStr options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, priceStr.length)];
            if (result) {
                for (NSTextCheckingResult *checkingRes in result) {
                    if (checkingRes.range.location == NSNotFound) {
                        continue;
                    }
                    NSLog(@"%@",[priceStr substringWithRange:checkingRes.range]);
                    //NSLog(@"%@",[priceStr substringWithRange:[res rangeAtIndex:1]]);
                }
            }
        return YES;
    }
    NSLog(@"匹配失败,Error: %@",error);
    return NO;
}


/*!
*  正则匹配
*
*  @param str     匹配的字符串
*  @param pattern 匹配规则
*
*  @return 返回匹配结果
*/
+ (BOOL)matchString:(NSString *)str withPattern:(NSString *)pattern resultBlock:(resultBlock)block {
    NSError *error = nil;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern: pattern options: NSRegularExpressionCaseInsensitive error: &error];
    if (!error) {
            NSTextCheckingResult *result = [regular firstMatchInString:str options:0 range:NSMakeRange(0, str.length)];
        if (result) {
            NSLog(@"匹配成功");
            block([str substringWithRange:result.range]);
            return YES;
        } else {
            NSLog(@"匹配失败");
            return NO;
        }
    }
    NSLog(@"匹配失败,Error: %@",error);
    return NO;
}


@end
