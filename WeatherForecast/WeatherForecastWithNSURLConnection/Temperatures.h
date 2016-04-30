//
//  Temperatures.h
//  WeatherForecastWithNSURLConnection
//
//  Created by Detailscool on 16/4/30.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Temperature;

@interface Temperatures : NSObject

@property(nonatomic,strong)NSString* wendu;

@property(nonatomic,strong)NSArray<Temperature *>* forecast;

@end
