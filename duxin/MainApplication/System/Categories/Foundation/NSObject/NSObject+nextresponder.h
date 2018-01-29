//
//  UIViewController+nextresponder.h
//  isoccer
//
//  Created by Seamus on 14-1-25.
//  Copyright (c) 2014年 Chlova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (nextresponder)
- (UIViewController *)responder:(NSObject *)_s className:(NSString *)_c;
- (UITableViewCell *)cellResponder:(NSObject *)_s className:(NSString *)_c;
@end
