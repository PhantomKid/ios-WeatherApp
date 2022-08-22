//
//  MyTabBarController.h
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import <UIKit/UIKit.h>
#import "WeatherData.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTabBarController : UITabBarController
@property(nonatomic, strong) WeatherData *weatherData;
@property (nonatomic, weak) IBOutlet UITabBar *myTabBar;
@end

NS_ASSUME_NONNULL_END
