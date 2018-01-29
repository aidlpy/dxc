//
//  NSString+Category.m
//  duxin
//
//  Created by 37duxin on 29/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)
-(NSString *)timeWithTimeIntervalString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
//    // 毫秒值转化为秒
//    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
@end
