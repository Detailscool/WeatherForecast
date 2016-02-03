//
//  ViewController.m
//  WeatherPredictWithNSConnection
//
//  Created by Detailscool on 16/2/3.
//  Copyright © 2016年 Detailscool. All rights reserved.
//

#import "ViewController.h"
#import "City.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;

@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@property (nonatomic,strong)NSArray * cities;

@property (nonatomic,strong)NSDictionary * weatherNumDict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.provinceLabel.text = [self.cities[0] name];
    self.cityLabel.text = [self.cities[0] cities][0];
    
}

#pragma mark - *****************数据源方法*****************

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.cities.count;
    }else
    {
        City * city = self.cities[[pickerView selectedRowInComponent:0]];
        return city.cities.count;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if(component == 0)
    {
        City * city = self.cities[row];
        return city.name;
    }else
    {
        NSInteger index = [pickerView selectedRowInComponent:0];
        City * city = self.cities[index];
//        NSLog(@"%@ - 城市个数：%ld,row:%ld",city.name,city.cities.count,row);
        //        if (city.cities.count > row) {
        //            return city.cities[row];
        //        }
        //        return nil;
        
        if (row > city.cities.count-1) {
            return nil;
        }return city.cities[row];
    }
}

#pragma mark - *****************代理方法*****************

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.showLabel.text = @"正在选择其他城市...";
    
    if (component == 0) {
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    
    City * city =self.cities[[pickerView selectedRowInComponent:0]];
    NSInteger index = [pickerView selectedRowInComponent:1];
    NSString * cityName = city.cities[index>city.cities.count?0:index];
    
    self.provinceLabel.text = city.name;
    self.cityLabel.text = cityName;
    
    
}

#pragma mark - *****************工具方法*****************

- (IBAction)check {
    
    [self performSelectorInBackground:@selector(checkInBackground) withObject:nil];
    
}

- (void)checkInBackground {
    
    NSString * numStr = nil;
    if(self.weatherNumDict[self.cityLabel.text]) {
        numStr = self.weatherNumDict[self.cityLabel.text];
    }else if(self.weatherNumDict[[self.cityLabel.text substringToIndex:self.cityLabel.text.length-1]]) {
        numStr = self.weatherNumDict[[self.cityLabel.text substringToIndex:self.cityLabel.text.length-1]];
    }else {
        self.showLabel.text = @"暂无该地区天气信息，请选择其他城市";
        return;
    }
    
    NSString * checkStr = [NSString stringWithFormat:@"http://wthrcdn.etouch.cn/weather_mini?citykey=%@",numStr];
    
    NSURL * url = [NSURL URLWithString:checkStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (data == nil) {
            self.showLabel.text = @"暂无该地区天气信息，请选择其他城市";
            return ;
        }
    
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray * forecast = dict[@"data"][@"forecast"];
        
        NSString * temp =[NSString stringWithFormat:@"现时温度：%@°C",dict[@"data"][@"wendu"]];
        NSString * weatherType =[NSString stringWithFormat:@"天气类型：%@°",forecast[0][@"type"]];
        NSString * wind =[NSString stringWithFormat:@"风向：%@",forecast[0][@"fengxiang"]];
        NSString * windForce =[NSString stringWithFormat:@"风力：%@",forecast[0][@"fengli"]];
        NSString * tempRange =[NSString stringWithFormat:@"%@ ~ %@°",forecast[0][@"low"],forecast[0][@"high"]];
        
        NSString * text = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@",temp,weatherType,wind,windForce,tempRange];
        
        self.showLabel.text = text;
        
        NSLog(@"%@",dict);
        
    }];

}

- (void)checkWithNum:(NSString *)numStr {
    // 此网有问题
    NSString *httpUrl = @"http://apis.baidu.com/heweather/pro/attractions";
    NSString *httpArg = [NSString stringWithFormat:@"cityid=CN%@18A",numStr];
    [self request: httpUrl withHttpArg: httpArg];

}

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"您自己的apikey" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request queue: [NSOperationQueue mainQueue]completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               
       NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
       
                               NSLog(@"%@",dict);
       
       if (error) {
           NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
       } else {
           NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
           NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           NSLog(@"HttpResponseCode:%ld", responseCode);
           NSLog(@"HttpResponseBody %@",responseString);
       }
                               
    }];
}

#pragma mark - *****************懒加载*****************
- (NSArray *)cities {
    if (!_cities) {
        _cities = [City cities];
    }
    return _cities;
}

- (NSDictionary *)weatherNumDict {
    if (!_weatherNumDict) {
        
        NSString * cityStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"WeatherNum.txt" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
        NSString * cityPattern = @"[\\u4e00-\\u9fa5]+";
        NSString * numPattern = @"[0-9]+";
        
        NSString * pattern = [NSString stringWithFormat:@"%@|%@",cityPattern,numPattern];
        
        NSRegularExpression * regular = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray * arr = [regular matchesInString:cityStr options:0 range:NSMakeRange(0, cityStr.length)];
        
        NSMutableArray * mtbArr = [NSMutableArray array];
        for (NSTextCheckingResult * result in arr) {
            //        NSLog(@"%@",[str substringWithRange:result.range]);
            NSString * temp = [cityStr substringWithRange:result.range];
            [mtbArr addObject:temp];
        }
        
        NSMutableDictionary * mtbDict = [NSMutableDictionary dictionary];
        for (int i = 1; i < mtbArr.count; i+=2) {
            [mtbDict setValue:mtbArr[i-1] forKey:mtbArr[i]];
        }
        
        _weatherNumDict = mtbDict.copy;
    }
    return _weatherNumDict;
}

@end
