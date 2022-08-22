//
//  MyTabBarController.m
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import "MyTabBarController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.weatherData = [[WeatherData alloc] init];
    UIViewController *vc;
    for (int i = 0; i < self.myTabBar.items.count; ++i) {
        vc = self.tabBarController.viewControllers[i];
        if ([vc respondsToSelector:@selector(getweatherData)]) {
            [vc setValue:_weatherData forKey:@"weatherData"];
        }
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
