//
//  main.m
//  Weather
//
//  Created by Kai on 2022/8/15.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WeatherData.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    //WeatherData *w = [[WeatherData alloc] init];
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        //w.cityName = @"深圳";
        //[w getWeekForcastDataOnline];
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
