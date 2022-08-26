//
//  ForcastViewController.m
//  Weather
//
//  Created by Kai on 2022/8/26.
//

#import "ForcastViewController.h"
#import "WeatherViewController.h"
#import "WeatherIndexController.h"
#import "GlobalVarAndFunc.h"

@implementation DayForCastView
-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //  初始化4个控件并分配空间
        const CGFloat y = self.frame.origin.y;
        const CGFloat x = frame.origin.x;
        const CGFloat height = frame.size.height / 6;
        const CGFloat width = frame.size.width;
        self.date = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, 1*height)];
        self.dayCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        self.dayCell.frame = CGRectMake(x, y+height, width, 2*height);
        self.nightCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        self.nightCell.frame = CGRectMake(x, y+3*height, width, 2*height);
        self.tempRangeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        self.tempRangeCell.frame = CGRectMake(x, y+5*height, width, 1*height);
        
        // 设置字体大小与颜色
        self.date.font = [UIFont systemFontOfSize:14.0];
        self.date.textColor = [UIColor grayColor];
        self.dayCell.textLabel.font = [UIFont systemFontOfSize:17.0];
        self.dayCell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
        self.nightCell.textLabel.font = [UIFont systemFontOfSize:17.0];
        self.nightCell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
        self.tempRangeCell.textLabel.font = [UIFont systemFontOfSize:17.0];
        
        // 将四个控件添加至自定义类的subview中
        [self addSubview: self.date];
        [self addSubview: self.dayCell];
        [self addSubview: self.nightCell];
        [self addSubview: self.tempRangeCell];
    }
    return self;
}
-(void) setForcastData:(SimpleWeatherData*) simpleWeatherData {
    // 日期
    self.date.text = simpleWeatherData.date;
    
    // 白天数据
    NSString *iconName = [[NSString alloc] initWithFormat:@"%ld", (long)simpleWeatherData.iconCodeDay];
    self.dayCell.imageView.image = [UIImage imageNamed:iconName];
    self.dayCell.imageView.frame = CGRectMake(10.0, 0.0, 20.0, 20.0);
    
    self.dayCell.textLabel.text = simpleWeatherData.textDay;
    self.dayCell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@,风力%@级,风速%@km/h", simpleWeatherData.windDirDay, simpleWeatherData.windScaleDay, simpleWeatherData.windSpeedDay];
    
    // 夜晚数据
    iconName = [[NSString alloc] initWithFormat:@"%ld", (long)simpleWeatherData.iconCodeNight];
    self.nightCell.imageView.image = [UIImage imageNamed:iconName];
    self.nightCell.imageView.frame = CGRectMake(10.0, 0.0, 20.0, 20.0);
    
    self.nightCell.textLabel.text = simpleWeatherData.textNight;
    self.nightCell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@,风力%@级,风速%@km/h", simpleWeatherData.windDirNight, simpleWeatherData.windScaleNight, simpleWeatherData.windSpeedNight];
    
    // 温度数据
    self.tempRangeCell.textLabel.text = [[NSString alloc] initWithFormat:@"最高温度%ld°C,最低温度%ld°C", (long)simpleWeatherData.tempMax, (long)simpleWeatherData.tempMin];
}
@end


@interface ForcastViewController ()

@end

@implementation ForcastViewController

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
    
    // 为三天的天气预报数据初始化并设置位置
    const int sectionNum = 3;
    const CGFloat margin = 10.0;
    const CGFloat heightPercentage = 0.618;
    const CGFloat height = heightPercentage*SCREEN_HEIGHT/sectionNum;
    const CGFloat width = SCREEN_WIDTH-margin;
    const CGFloat y0 = 44+32; //
    CGRect viewRange0 = CGRectMake(margin, y0, width, height);
    CGRect viewRange1 = CGRectMake(margin, y0+0.6*height, width, height);
    CGRect viewRange2 = CGRectMake(margin, y0+1.2*height, width, height);
    
    self.day0 = [[DayForCastView alloc] initWithFrame:viewRange0];
    self.day1 = [[DayForCastView alloc] initWithFrame:viewRange1];
    self.day2 = [[DayForCastView alloc] initWithFrame:viewRange2];
    
    // 将三个自定义控件加到self.view上使之能够呈现
    [self.view addSubview: self.day0];
    [self.view addSubview: self.day1];
    [self.view addSubview: self.day2];
    
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
    [self loadViewWithWeatherForcastData:nil];
}
-(void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weatherForcastDidGet" object:nil];
}

-(void) loadViewWithWeatherForcastData:(NSNotification *)notification {
    if (notification != nil) {
        NSLog(@"getForcast");
        WeatherData *getData = notification.userInfo[@"key"];
        self.weatherData = getData;
    }
    NSString *cityName = [[NSString alloc] initWithFormat:@"+ %@", self.weatherData.cityName];
    [self.cityButton setTitle:cityName forState:UIControlStateNormal];
    ADJUST_MID_LABEL_WIDTH(self.cityButton.titleLabel);
    [self.cityButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self showWeatherForcast];
}

-(void) showWeatherForcast {
    [self.day0 setForcastData: [self.weatherData.weekForcastData objectAtIndex:0]];
    [self.day1 setForcastData: [self.weatherData.weekForcastData objectAtIndex:1]];
    [self.day2 setForcastData: [self.weatherData.weekForcastData objectAtIndex:2]];
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
