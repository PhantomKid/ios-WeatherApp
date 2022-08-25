//
//  WeatherIndexController.m
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import "WeatherIndexController.h"
#import "WeatherViewController.h"
#import "GlobalVarAndFunc.h"

@interface WeatherIndexController ()

@end

@implementation WeatherIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 将本类的weatherData变量与WeatherViewController中的weatherData关联起（享有同一数据）
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
    
    // 注册观察者，用以接收weatherIndiceDidGet消息，接收到该信息后调用loadViewWithWeatherIndiceData函数从而展示天气信息
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(loadViewWithWeatherIndiceData:) name:@"weatherIndiceDidGet" object:nil];
    
    if (self.weatherData.cityName != nil) {
        [self loadViewWithWeatherIndiceData:nil];
        return;
    }
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weatherIndiceDidGet" object:nil];
}

-(void) loadViewWithWeatherIndiceData:(NSNotification *)gotDataNotification {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
