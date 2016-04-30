//
//  Temperature.h
//  WeatherForecastWithNSURLConnection
//
//  Created by Detailscool on 16/4/30.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Temperature : NSObject

@property(nonatomic,strong)NSString* type;

@property(nonatomic,strong)NSString* fengxiang;

@property(nonatomic,strong)NSString* fengli;

@property(nonatomic,strong)NSString* low;

@property(nonatomic,strong)NSString* high;

@property(nonatomic,strong)NSString* date;

@end
