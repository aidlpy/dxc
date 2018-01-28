//
//  GCD.m
//  duxin
//
//  Created by 37duxin on 28/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "GCD.h"

@implementation GCD
+(void)getGlobalThread:(void(^)(void))globalBlock mainThread:(void(^)(void))mainBlock{
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
         globalBlock();
          dispatch_async(dispatch_get_main_queue(), ^{
              mainBlock();
          });
     });
}
@end
