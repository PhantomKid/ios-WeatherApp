//
//  WeatherViewController.h
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import <UIKit/UIKit.h>
#import "WeatherData.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherViewController : UIViewController
@property(nonatomic, strong) WeatherData *weatherData;
@property(weak) IBOutlet UIButton *cityButton;
- (IBAction)selectCity:(id)sender;
@property (weak, nonatomic) IBOutlet UITableViewCell *updateTime;
@property(nonatomic, strong) UITableViewCell *text;
@property(nonatomic, strong) UITableViewCell *humidity;
@property(nonatomic, strong) UITableViewCell *pressure;
@property(nonatomic, strong) UITableViewCell *windDir;
@property(nonatomic, strong) UITableViewCell *windScale;
@property(nonatomic, strong) UITableViewCell *windSpeed;
-(void) loadViewWithWeatherData: (NSNotification *__nullable) notification;
-(void) showWeatherData;
@end

NS_ASSUME_NONNULL_END
