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
@property (weak, nonatomic) IBOutlet UITableViewCell *text;
@property (weak, nonatomic) IBOutlet UILabel *temp;
-(void) loadViewWithWeatherData: (NSNotification *) gotDataNotification;
-(void) showWeatherData;
@end

NS_ASSUME_NONNULL_END
