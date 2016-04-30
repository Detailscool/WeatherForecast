//
//  NSDate+Extension.h
//
//  Created by Detailscool on 16/1/22.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

- (NSString *)stringFromDateWithFormat:(NSString *)format;

+ (instancetype)dateFromString:(NSString *)string andFormat:(NSString *)format;

- (NSDateComponents *)dateComponentsDateToNow;

- (BOOL)isThisYear;

- (BOOL)isToday;

- (BOOL)isYesterday;

@end


@interface NSString (DateExtension)

- (NSString *)timeStateForSocialNetwork:(NSString *)format;

@end