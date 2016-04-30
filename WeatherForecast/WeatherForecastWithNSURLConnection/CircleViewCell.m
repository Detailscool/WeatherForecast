//
//  CircleViewCell.m
//  WeatherForecastWithNSURLConnection
//
//  Created by Detailscool on 16/4/30.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

#import "CircleViewCell.h"
#import <Masonry/Masonry.h>

@interface CircleViewCell ()

@property (weak, nonatomic)UILabel *dateLabel;

@end

@implementation CircleViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
        
        UILabel * label = [[UILabel alloc]init];
        self.dateLabel = label;
        [self.contentView addSubview:label];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}



- (void)setDate:(NSString *)date {
    _date = date;
    
    self.dateLabel.text = date;
    
}

@end
