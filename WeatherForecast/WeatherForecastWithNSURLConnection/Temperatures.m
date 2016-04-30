//
//  Temperatures.m
//  WeatherForecastWithNSURLConnection
//
//  Created by Detailscool on 16/4/30.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

#import "Temperatures.h"
#import "Temperature.h"

@implementation Temperatures

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"forecast" : [Temperature class]};
}

@end
