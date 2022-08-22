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
@property(nonatomic, weak) WeatherData *weatherData;
@property(weak) IBOutlet UIButton *cityButton;
@property(weak) IBOutlet UITableView *weatherDataTV;
@end

NS_ASSUME_NONNULL_END
