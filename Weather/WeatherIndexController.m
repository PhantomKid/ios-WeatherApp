//
//  WeatherIndexController.m
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import "WeatherIndexController.h"
#import "WeatherViewController.h"
#import "ForcastViewController.h"
#import "GlobalVarAndFunc.h"

@interface WeatherIndexController ()

@end

@implementation WeatherIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 用WeatherViewController中的weatherData给本类的weatherData初始化
    WeatherViewController *wvc = [self.tabBarController.viewControllers objectAtIndex:0];
    self.weatherData = wvc.weatherData;
        
    // 动态调整城市label的宽度
    UILabel *cityLabel = self.cityButton.titleLabel;
    cityLabel.text = @"+ 选择城市";
    self.cityButton.frame = CGRectMake(146, 44, 122, 32);
    ADJUST_MID_LABEL_WIDTH(cityLabel);
    
    // 初始化三个生活指数
    self.comfortIndex = [[UILabel alloc] init];
    self.sportIndex = [[UILabel alloc] init];
    self.makeupIndex = [[UILabel alloc] init];
    
    // 设置字体大小
    const CGFloat fontSize = 17.0;
    self.comfortIndex.font = [UIFont systemFontOfSize:fontSize];
    self.sportIndex.font = [UIFont systemFontOfSize:fontSize];
    self.makeupIndex.font = [UIFont systemFontOfSize:fontSize];
    
    // 除去label显示行数的限制
    self.comfortIndex.numberOfLines = 0;
    self.sportIndex.numberOfLines = 0;
    self.makeupIndex.numberOfLines = 0;
    
    // 将3个labels添加到self.view上使之能够呈现
    [self.view addSubview:self.comfortIndex];
    [self.view addSubview:self.sportIndex];
    [self.view addSubview:self.makeupIndex];
    
    // 获取3个labels的起始y值
    CGFloat y0 = self.cityButton.frame.origin.y + self.cityButton.frame.size.height;
    
    // 为3个labels设置高度和宽度（利用屏幕高度的黄金分割比作为总高度，用屏幕宽度作为宽度）
    const int cellNum = 3;
    const CGFloat margin = 10.0;
    const CGFloat heightPercentage = 0.8;
    SET_WIDTH_AND_HEIGHT_TOGETHER_WITH_OVERALL_HEIGHT_PERCENTAGE(self.comfortIndex.frame, margin, y0, cellNum, heightPercentage);
    SET_WIDTH_AND_HEIGHT_TOGETHER_WITH_OVERALL_HEIGHT_PERCENTAGE(self.sportIndex.frame, margin, y0, cellNum, heightPercentage);
    SET_WIDTH_AND_HEIGHT_TOGETHER_WITH_OVERALL_HEIGHT_PERCENTAGE(self.makeupIndex.frame, margin, y0, cellNum, heightPercentage);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 未获得具体城市直接返回
    if (self.weatherData.cityName == nil) return;
    // 界面无需刷新直接返回(self.weather.cityName与cityButton的城市是一样的，但是cityButton的字符串前多了"+ ")
    NSString *str = [[NSString alloc] initWithFormat:@"+ %@", self.weatherData.cityName];
    if (self.weatherData.cityName != nil && self.cityButton.titleLabel.text != nil && [str isEqualToString: self.cityButton.titleLabel.text]) {
        return;
    }
    [self loadViewWithWeatherIndiceData:nil];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weatherIndiceDidGet" object:nil];
}

-(void) loadViewWithWeatherIndiceData:(NSNotification *)notification {
    if (notification != nil) {
        NSLog(@"getIndice");
        WeatherData *getData = notification.userInfo[@"key"];
        self.weatherData = getData;
    }
    NSString *cityName = [[NSString alloc] initWithFormat:@"+ %@", self.weatherData.cityName];
    [self.cityButton setTitle:cityName forState:UIControlStateNormal];
    ADJUST_MID_LABEL_WIDTH(self.cityButton.titleLabel);
    [self.cityButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self showWeatherIndice];
}

-(void) showWeatherIndice {
    // 舒适度指数
    self.comfortIndex.text = [self.weatherData.comfortIndex toString];
    self.sportIndex.text = [self.weatherData.sportIndex toString];
    self.makeupIndex.text = [self.weatherData.makeupIndex toString];
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
