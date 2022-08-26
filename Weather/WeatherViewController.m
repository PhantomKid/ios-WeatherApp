//
//  WeatherViewController.m
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import "WeatherViewController.h"
#import "WeatherIndexController.h"
#import "ForcastViewController.h"
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
    self.cityButton.frame = CGRectMake(146, 44, 122, 32);
    ADJUST_MID_LABEL_WIDTH(cityLabel);
    
    // 设置updateTime的字体颜色和大小
    [self.updateTime.textLabel setTextColor:[UIColor grayColor]];
    [self.updateTime.textLabel setFont:[UIFont systemFontOfSize:14.0]];
    
    // 初始化6个数据栏
    const CGFloat fontSize = 17.0;
    INIT_CELL(self.text, fontSize);
    INIT_CELL(self.humidity, fontSize);
    INIT_CELL(self.pressure, fontSize);
    INIT_CELL(self.windDir, fontSize);
    INIT_CELL(self.windScale, fontSize);
    INIT_CELL(self.windSpeed, fontSize);
    
    // 将6个cells添加到self.view上使之能够呈现
    [self.view addSubview: self.text];
    [self.view addSubview: self.humidity];
    [self.view addSubview: self.pressure];
    [self.view addSubview: self.windDir];
    [self.view addSubview: self.windScale];
    [self.view addSubview: self.windSpeed];
    
    // 获取6个数据栏的起始y值
    CGFloat y0 = self.updateTime.frame.origin.y + self.updateTime.frame.size.height;
    
    // 为6个数据栏设置高度和宽度（利用屏幕高度的黄金分割比作为总高度，用屏幕宽度作为宽度）
    const int cellNum = 6;
    const CGFloat margin = 6.0;
    SET_WIDTH_AND_HEIGHT_TOGETHER_USING_HEIGHT_GOLDEN_SECTION(self.text.frame, margin, y0, cellNum);
    SET_WIDTH_AND_HEIGHT_TOGETHER_USING_HEIGHT_GOLDEN_SECTION(self.humidity.frame, margin, y0, cellNum);
    SET_WIDTH_AND_HEIGHT_TOGETHER_USING_HEIGHT_GOLDEN_SECTION(_pressure.frame, margin, y0, cellNum);
    SET_WIDTH_AND_HEIGHT_TOGETHER_USING_HEIGHT_GOLDEN_SECTION(self.windDir.frame,margin, y0, cellNum);
    SET_WIDTH_AND_HEIGHT_TOGETHER_USING_HEIGHT_GOLDEN_SECTION(self.windScale.frame,margin, y0, cellNum);
    SET_WIDTH_AND_HEIGHT_TOGETHER_USING_HEIGHT_GOLDEN_SECTION(self.windSpeed.frame,margin, y0, cellNum);
    
    // 生成一个WeatherData对象
    self.weatherData = [[WeatherData alloc] init];
    
    // 为三个UI界面注册observer
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    WeatherIndexController *wic = [self.tabBarController.viewControllers objectAtIndex:1];
    ForcastViewController *fvc = [self.tabBarController.viewControllers objectAtIndex:2];
    [center addObserver:self selector:@selector(loadViewWithWeatherData:) name:@"weatherDataDidGet" object:nil];
    [center addObserver:wic selector:@selector(loadViewWithWeatherIndiceData:) name:@"weatherIndiceDidGet" object:nil];
    [center addObserver:fvc selector:@selector(loadViewWithWeatherForcastData:) name:@"weatherForcastDidGet" object:nil];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 未获得具体城市直接返回
    if (self.weatherData.cityName == nil) return;
    // 界面无需刷新直接返回(self.weather.cityName与cityButton的城市是一样的，但是cityButton的字符串前多了"+ ")
    NSString *str = [[NSString alloc] initWithFormat:@"+ %@", self.weatherData.cityName];
    if (self.weatherData.cityName != nil && self.cityButton.titleLabel.text != nil && [str isEqualToString: self.cityButton.titleLabel.text]) {
        return;
    }
    [self loadViewWithWeatherData:nil];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weatherDataDidGet" object:nil];
}

-(void) loadViewWithWeatherData:(NSNotification *)notification {
    if (notification != nil) {
        NSLog(@"getWeatherData");
        WeatherData *getData = notification.userInfo[@"key"];
        self.weatherData = getData;
    }

    NSString *cityName = [[NSString alloc] initWithFormat:@"+ %@", self.weatherData.cityName];
    [self.cityButton setTitle:cityName forState:UIControlStateNormal];
    ADJUST_MID_LABEL_WIDTH(self.cityButton.titleLabel);
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
    self.text.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@°C", self.weatherData.temp];
    
    // 湿度栏
    self.humidity.textLabel.text = @"相对湿度";
    self.humidity.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@%%",self.weatherData.humidity];
    
    // 气压栏
    self.pressure.textLabel.text = @"气压";
    self.pressure.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@hPa", self.weatherData.pressure];
    
    // 风向栏
    self.windDir.textLabel.text = @"风向";
    self.windDir.detailTextLabel.text = self.weatherData.windDir;
    
    // 风力栏
    self.windScale.textLabel.text = @"风力等级";
    self.windScale.detailTextLabel.text = self.weatherData.windScale;
    
    // 风速栏
    self.windSpeed.textLabel.text = @"风速";
    self.windSpeed.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@km/h", self.weatherData.windSpeed];
}

- (IBAction)selectCity:(id)sender {
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UIViewController *destVC = [segue destinationViewController];
    if ([destVC respondsToSelector:@selector(setWeatherData:)]) {
        [destVC setValue:_weatherData forKey:@"weatherData"];
    }
}

@end
