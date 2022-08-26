//
//  ForcastViewController.h
//  Weather
//
//  Created by Kai on 2022/8/26.
//

#import <UIKit/UIKit.h>
#import "WeatherData.h"

NS_ASSUME_NONNULL_BEGIN

@interface DayForCastView : UIView
@property(nonatomic, strong) UILabel *date;
@property(nonatomic, strong) UITableViewCell *dayCell;
@property(nonatomic, strong) UITableViewCell *nightCell;
@property(nonatomic, strong) UITableViewCell *tempRangeCell;
-(instancetype) initWithFrame:(CGRect)frame;
-(void) setForcastData:(SimpleWeatherData*) simpleWeatherData;
@end

@interface ForcastViewController : UIViewController
@property(atomic, weak) WeatherData *weatherData;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property(nonatomic, strong) DayForCastView *day0;
@property(nonatomic, strong) DayForCastView *day1;
@property(nonatomic, strong) DayForCastView *day2;
-(void) loadViewWithWeatherForcastData: (NSNotification *__nullable) notification;
-(void) showWeatherForcast;
@end

NS_ASSUME_NONNULL_END
