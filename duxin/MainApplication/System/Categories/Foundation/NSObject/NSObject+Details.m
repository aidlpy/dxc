//
//  NSObject+Details.m
//  lark
//
//  Created by Onery on 15/10/13.
//  Copyright © 2015年 quncaotech. All rights reserved.
//

#import "NSObject+Details.h"
#import <objc/runtime.h>
@implementation NSObject (Details)
+ (NSDictionary *)getAllPropertiesAndVaulesWithClass:(NSObject * )cls{
    NSMutableDictionary *propertiesAndVaulesDic = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([cls class], &outCount);
    for (i = 0; i<outCount; i++){
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [cls valueForKey:(NSString *)propertyName];
        if (propertyValue) [propertiesAndVaulesDic setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return propertiesAndVaulesDic;
}

+ (NSArray *)getAllPropertiesWithClass:(NSObject * )cls{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([cls class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++){
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

+ (void)getAllMethodsWithClass:(NSObject * )cls{
    unsigned int mothCout_f =0;
    Method* mothList_f = class_copyMethodList([cls class],&mothCout_f);
    for(int i=0;i<mothCout_f;i++){
        Method temp_f = mothList_f[i];
        IMP imp_f = method_getImplementation(temp_f);
        SEL name_f = method_getName(temp_f);
        const char* name_s =sel_getName(method_getName(temp_f));
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding =method_getTypeEncoding(temp_f);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s], arguments, [NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
}
@end
