//
//  WeatherViewController.m
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import "WeatherViewController.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface WeatherViewController ()

@end

@implementation WeatherViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //动态调整城市label的宽度
    UILabel *cityLabel = self.cityButton.titleLabel;
    cityLabel.textAlignment = NSTextAlignmentCenter;
    cityLabel.text = @"+ 选择城市";
    CGSize size = [cityLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:cityLabel.font, NSFontAttributeName, nil]];
    CGFloat width = size.width;
    cityLabel.frame = CGRectMake(0.5*(SCREEN_WIDTH-width), cityLabel.frame.origin.y, width, cityLabel.frame.size.height);
    
    // 修改天气栏使其宽度为当前设备宽度
    self.text.frame = CGRectMake(self.text.frame.origin.x, self.text.frame.origin.y, SCREEN_WIDTH, self.text.frame.size.height);
    
    // 修改天气栏内的温度label位置为天气栏的最右侧
    self.temp.frame = CGRectMake(SCREEN_WIDTH-self.temp.frame.size.width, self.temp.frame.origin.y, self.temp.frame.size.width, self.temp.frame.size.height);
    
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
    [self.cityButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self showWeatherData];
}

-(void) showWeatherData {
    self.updateTime.textLabel.text = [[NSString alloc] initWithFormat:@"数据更新于%@", self.weatherData.updateTime];
    NSString *iconName = [[NSString alloc] initWithFormat:@"%ld", (long)self.weatherData.iconCode];
    self.text.imageView.image = [UIImage imageNamed:iconName];
    self.text.imageView.frame = CGRectMake(10.0, 0.0, 20.0, 20.0);
    self.text.textLabel.text = self.weatherData.text;
    self.temp.text = self.weatherData.temp;
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
