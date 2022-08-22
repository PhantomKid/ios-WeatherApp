//
//  PlaceSelectionViewController.h
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import <UIKit/UIKit.h>
#import "WeatherData.h"
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlaceSelectionViewController : UIViewController <UISearchBarDelegate, CLLocationManagerDelegate>
@property(atomic, nullable, copy) NSString *prevText;
@property(weak) WeatherData *weatherData;
@property(weak) IBOutlet UISearchBar *citySearchBar;
@property(weak) IBOutlet UIButton *getCurrentLocationButton;
@property(nonatomic, strong) CLLocationManager *locationManager;
-(void) cityNameDidGet:(NSString *_Nonnull) cityName;
- (IBAction)locationButtonClicked:(id)sender;
@end

NS_ASSUME_NONNULL_END
