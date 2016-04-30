//
//  City.h
//  UIDatePickerTest
//
//  Created by Detailscool on 15/12/26.
//  Copyright © 2015年 Detailscool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface City : UIView

@property (nonatomic,strong)NSArray * cities;
@property (nonatomic,copy)NSString * name;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype) cityWithDictionary:(NSDictionary *)dict;

+ (NSArray *)cities;

@end
