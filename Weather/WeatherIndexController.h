//
//  WeatherIndexController.h
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import <UIKit/UIKit.h>
#import "WeatherData.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherIndexController : UIViewController
@property (atomic, weak) WeatherData *weatherData;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (nonatomic, strong) UILabel *comfortIndex;
@property (nonatomic, strong) UILabel *sportIndex;
@property (nonatomic, strong) UILabel *makeupIndex;
-(void) loadViewWithWeatherIndiceData: (NSNotification *__nullable) gotDataNotification;
-(void) showWeatherIndice;
@end

NS_ASSUME_NONNULL_END
