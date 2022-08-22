//
//  WeatherViewController.m
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import "WeatherViewController.h"

/*
@implementation MyLocationManager
-(instancetype) init {
    self = [super init];
    return self;
}
@end*/

@interface WeatherViewController ()

@end

@implementation WeatherViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.weatherData = [[WeatherData alloc] init];
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


- (IBAction)getCurrentLocationButton:(id)sender {
}
@end
