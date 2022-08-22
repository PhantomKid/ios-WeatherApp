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
@end

NS_ASSUME_NONNULL_END
