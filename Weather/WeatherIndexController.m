//
//  WeatherIndexController.m
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import "WeatherIndexController.h"
#import "WeatherViewController.h"

@interface WeatherIndexController ()

@end

@implementation WeatherIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WeatherData *wd = [[WeatherData alloc] init];
    self.weatherData = wd;
    WeatherViewController *wvc = [self.tabBarController.viewControllers objectAtIndex:0];
    self.weatherData = wvc.weatherData;
    NSLog(@"%@", self.weatherData.cityName);
    if (self.weatherData.cityName != nil) {
        NSString *cityName = [[NSString alloc] initWithFormat:@"+ %@", self.weatherData.cityName];
        [self.cityButton setTitle:cityName forState:UIControlStateNormal];
        [self.cityButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    }
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
