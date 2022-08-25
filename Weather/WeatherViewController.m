//
//  WeatherViewController.m
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import "WeatherViewController.h"
#import "GlobalVarAndFunc.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    //动态调整城市label的宽度
    UILabel *cityLabel = self.cityButton.titleLabel;
    cityLabel.text = @"+ 选择城市";
    ADJUST_MID_LABEL_WIDTH(cityLabel);
    /*CGSize size = [cityLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:cityLabel.font, NSFontAttributeName, nil]];
    CGFloat width = size.width;
    cityLabel.frame = CGRectMake(0.5*(SCREEN_WIDTH-width), cityLabel.frame.origin.y, width, cityLabel.frame.size.height);*/
    
    // 设置updateTime的字体颜色和大小
    [self.updateTime.textLabel setTextColor:[UIColor grayColor]];
    [self.updateTime.textLabel setFont:[UIFont systemFontOfSize:14.0]];
    
    // 修改天气栏使其宽度为当前设备宽度
    SET_WIDTH_AS_SCREEN_WIDTH(self.text.frame);
    
    // 修改天气栏内的温度label位置为天气栏的最右侧
    SET_VALUE_AS_THE_RIGHTMOST_OF_CELL(self.temp.frame);
    
    // 修改湿度栏使其宽度为当前设备宽度，湿度值label置于cell的最右侧
    SET_WIDTH_AS_SCREEN_WIDTH(self.humidity.frame);
    SET_VALUE_AS_THE_RIGHTMOST_OF_CELL(self.humidityValue.frame);
    
    // 修改气压栏使其宽度为当前设备宽度，气压值label置于cell的最右侧
    SET_WIDTH_AS_SCREEN_WIDTH(self.pressure.frame);
    SET_VALUE_AS_THE_RIGHTMOST_OF_CELL(self.pressureValue.frame);
    
    self.weatherData = [[WeatherData alloc] init];
    
    // 注册观察者，用以接收weatherDataDidGet消息，接收到该信息后调用loadViewWithWeatherData函数从而展示天气信息
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(loadViewWithWeatherData:) name:@"weatherDataDidGet" object:nil];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weatherDataDidGet" object:nil];
}

-(void) loadViewWithWeatherData:(NSNotification *)gotDataNotification {
    NSLog(@"getNotification");
    NSString *cityName = [[NSString alloc] initWithFormat:@"+ %@", self.weatherData.cityName];
    [self.cityButton setTitle:cityName forState:UIControlStateNormal];
    ADJUST_RIGHTMOST_LABEL_WIDTH(self.cityButton.titleLabel);
    [self.cityButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self showWeatherData];
}

-(void) showWeatherData {
    // 更新时间
    self.updateTime.textLabel.text = [[NSString alloc] initWithFormat:@"数据更新于%@", self.weatherData.updateTime];
    
    // 天气栏（天气图标+内容+温度）
    NSString *iconName = [[NSString alloc] initWithFormat:@"%ld", (long)self.weatherData.iconCode];
    self.text.imageView.image = [UIImage imageNamed:iconName];
    self.text.imageView.frame = CGRectMake(10.0, 0.0, 20.0, 20.0);
    self.text.textLabel.text = self.weatherData.text;
    self.temp.text = self.weatherData.temp;
    ADJUST_RIGHTMOST_LABEL_WIDTH(self.temp);
    
    // 湿度栏
    self.humidity.textLabel.text = @"湿度";
    self.humidityValue.text = self.weatherData.humidity;
    ADJUST_RIGHTMOST_LABEL_WIDTH(self.humidityValue);
    
    // 气压栏
    self.pressure.textLabel.text = @"气压";
    self.pressureValue.text = [[NSString alloc] initWithFormat:@"%@kPa", self.weatherData.pressure];
    ADJUST_RIGHTMOST_LABEL_WIDTH(self.pressureValue);
}

- (IBAction)selectCity:(id)sender {
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"segue");
    UIViewController *destVC = [segue destinationViewController];
    /*if ([destVC respondsToSelector:@selector(setDelegate:)]) {
        [destVC setValue:self forKey:@"delegate"];
    }*/
    if ([destVC respondsToSelector:@selector(setWeatherData:)]) {
        [destVC setValue:_weatherData forKey:@"weatherData"];
    }
}

@end
