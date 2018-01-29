//
//  UIViewController+nextresponder.m
//  isoccer
//
//  Created by Seamus on 14-1-25.
//  Copyright (c) 2014年 Chlova. All rights reserved.
//

#import "NSObject+nextresponder.h"

@implementation NSObject (nextresponder)
- (UIViewController *)responder:(NSObject *)_s className:(NSString *)_c
{
    NSArray *a = [_c componentsSeparatedByString:@"|"];
    for (NSString *cl in a) {
        if ([_s isKindOfClass:NSClassFromString(cl)]) {
            return (UIViewController *)_s;
        }
    }
    NSObject *obj = [(UIViewController *)_s nextResponder];
    if (!obj) {
        return nil;
    }
    return [self responder:obj className:_c];
}


- (UITableViewCell *)cellResponder:(NSObject *)_s className:(NSString *)_c{
    NSArray *a = [_c componentsSeparatedByString:@"|"];
    for (NSString *cl in a) {
        if ([_s isKindOfClass:NSClassFromString(cl)]) {
            return (UITableViewCell *)_s;
        }
    }
    NSObject *obj = [(UITableViewCell *)_s nextResponder];
    if (!obj) {
        return nil;
    }
    return [self cellResponder:obj className:_c];
}
@end
