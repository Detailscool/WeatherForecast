//
//  NSDate+Extension.m
//
//  Created by Detailscool on 16/1/22.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSString *)stringFromDateWithFormat:(NSString *)format {
    
    NSDateFormatter * dfm = [[NSDateFormatter alloc]init];
    
    dfm.dateFormat = format;
    
    return [dfm stringFromDate:self];
    
}

+ (instancetype)dateFromString:(NSString *)string andFormat:(NSString *)format {
    
    NSDateFormatter * dfm = [[NSDateFormatter alloc]init];
    
    dfm.dateFormat = format;
    
    return [dfm dateFromString:string];
    
}

- (NSDateComponents *)dateComponentsDateToNow {
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return  [[NSCalendar currentCalendar] components:unit fromDate:self toDate:[NSDate date] options:0];
    
}

- (BOOL)isThisYear {
    return [[NSCalendar currentCalendar]components:NSCalendarUnitYear fromDate:self].year == [[NSCalendar currentCalendar]components:NSCalendarUnitYear fromDate:[NSDate date]].year;
}

- (BOOL)isToday {
    return [[NSCalendar currentCalendar]isDateInToday:self];
}

- (BOOL)isYesterday {
    return [[NSCalendar currentCalendar]isDateInYesterday:self];
}

@end


@implementation NSString (DateExtension)

- (NSString *)timeStateForSocialNetwork:(NSString *)format {
    
    NSDate * createDate = [NSDate dateFromString:self andFormat:format];
    
    if (createDate.isThisYear) {
        
        if (createDate.isToday) {
            
            if ([createDate dateComponentsDateToNow].hour > 1) {
                // 1小时前
                return [NSString stringWithFormat:@"%zd小时前",[createDate dateComponentsDateToNow].hour];
            }else if ([createDate dateComponentsDateToNow].minute > 1) {
                // 大于1分钟&1小时内
                return [NSString stringWithFormat:@"%zd分钟前",[createDate dateComponentsDateToNow].minute];
            }else {
                // 1分钟内
                return @"刚刚";
            }
            
        }else if (createDate.isYesterday) {
            // 昨天
            return [NSString stringWithFormat:@"昨天 %@",[createDate stringFromDateWithFormat:@"HH:mm"]];
            
        }else {
            // 既不是今天也不是昨天
            return [NSString stringWithFormat:@"%@",[createDate stringFromDateWithFormat:@"MM-dd HH:mm"]];
        }
        
    }else {
        // 非今年 显示全日期
        return self;
    }
    
}
@end
