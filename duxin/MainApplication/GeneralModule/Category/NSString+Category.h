//
//  NSString+Category.h
//  duxin
//
//  Created by 37duxin on 29/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
-(NSString *)timeWithTimeIntervalString;
-(NSString *)timeWithTimeIntervalFullString;
-(NSString *)timeWithTimeIntervalFullStringWithHizon;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
