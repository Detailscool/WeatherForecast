//
//  City.m
//  UIDatePickerTest
//
//  Created by Detailscool on 15/12/26.
//  Copyright © 2015年 Detailscool. All rights reserved.
//

#import "City.h"

@implementation City

- (instancetype) initWithDictionary:(NSDictionary * )dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype) cityWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}

+ (NSArray *)cities
{
    NSString * path = [[NSBundle mainBundle]pathForResource:@"cities.plist" ofType:nil];
    
    NSArray * arr = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray * mtbArr = [NSMutableArray array];
    
    for (NSDictionary * dict in arr) {
        City * city =[City cityWithDictionary:dict];
        [mtbArr addObject:city];
    }
    return mtbArr;
}

@end
