//
//  UIControl+AvoidMultipleClick.m
//  lark
//
//  Created by baohui.qct on 15/9/18.
//  Copyright © 2015年 quncaotech. All rights reserved.
//

#import "UIControl+AvoidMultipleClick.h"
#import "objc/runtime.h"

//#define AVOID_MULTIPLECLICK_UICONTROL

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char * UIControl_ignoreEvent="ignoreClickEvent";
@implementation UIControl (AvoidMultipleClick)

-(NSTimeInterval)am_acceptEventInterval
{
   return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}
-(BOOL)am_ignoreEvent
{
    return [objc_getAssociatedObject(self, UIControl_ignoreEvent) boolValue];
}
-(void)setAm_acceptEventInterval:(NSTimeInterval)am_acceptEventInterval
{
      objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(am_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)setAm_ignoreEvent:(BOOL)am_ignoreEvent
{
    objc_setAssociatedObject(self, UIControl_ignoreEvent, @(am_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
#ifdef AVOID_MULTIPLECLICK_UICONTROL
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(__uxy_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
#endif
}

- (void)__uxy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.am_acceptEventInterval > 0)
    {
        self.am_ignoreEvent = YES;
        [self performSelector:@selector(setAm_ignoreEvent:) withObject:@(NO) afterDelay:self.am_acceptEventInterval];
    }
    [self __uxy_sendAction:action to:target forEvent:event];
}
@end
