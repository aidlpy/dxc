//
//  NSObject+ListenNotification.m
//  lark
//
//  Created by liuys on 15/7/17.
//  Copyright © 2015年 quncaotech. All rights reserved.
//

#import "NSObject+ListenNotification.h"

#pragma LKListenNotificationWrap

@interface LKListenNotificationWrap : NSObject
@property (atomic,strong) id blockObserver;
@end

@implementation LKListenNotificationWrap
-(void) dealloc {
    if (self.blockObserver!=NULL) {
        [[NSNotificationCenter defaultCenter] removeObserver:self.blockObserver];
    }
}
@end


#pragma ListenNotification

@implementation NSObject(ListenNotification)

static char kListenNotificationKey;

-(void)listenNotificationWithName:(NSString *)name object:(id)obj usingBlock:(void (^)(NSNotification * note))block {
    
    LKListenNotificationWrap* wrap = [[LKListenNotificationWrap alloc] init];
    id blockObserver = [[NSNotificationCenter defaultCenter] addObserverForName:name
                                                                            object:obj
                                                                            queue:[NSOperationQueue mainQueue]
                                                                            usingBlock:block];
    objc_setAssociatedObject(self,&kListenNotificationKey, wrap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    wrap.blockObserver = blockObserver;
}


-(void)unlistenNotificationWithName:(NSString *)name  {
    objc_setAssociatedObject(self,&kListenNotificationKey,nil,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
