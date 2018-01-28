//
//  GCD.h
//  duxin
//
//  Created by 37duxin on 28/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCD : NSObject
+(void)getGlobalThread:(void(^)(void))globalBlock mainThread:(void(^)(void))mainBlock;
@end
