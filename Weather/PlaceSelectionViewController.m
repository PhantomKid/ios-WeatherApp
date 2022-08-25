//
//  PlaceSelectionViewController.m
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import "PlaceSelectionViewController.h"

@interface PlaceSelectionViewController ()

@end

@implementation PlaceSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.citySearchBar.delegate = self;
    [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].title = @"取消";
    self.prevText = nil;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyReduced;
    self.locationManager.distanceFilter = 5; //kCLDistanceFilterNone;
}

-(void) cityNameDidGet:(NSString *)cityName {
    self.weatherData.cityName = cityName;
    [self.weatherData getWeatherDataOnline];
    [self.weatherData getWeatherIndiceOnline];
    [self.weatherData getWeekForcastDataOnline];
}

-(void) locationButtonClicked:(id)sender {
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
        NSLog(@"AuthorizationDenied = %d", [self.locationManager authorizationStatus] == kCLAuthorizationStatusDenied);
    }
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"didUpdateLocations");
    CLLocation *currLocation = locations.lastObject;
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSString *cityName = placemark.locality;
            if (cityName == nil) {
                NSLog(@"3");
                // 直辖市无法通过locality获取
                cityName = placemark.administrativeArea;
            }
            if (cityName != nil) {
                NSLog(@"4");
                [self cityNameDidGet:cityName];
            }
        }
        if (error) {
            NSLog(@"error = %@", error);
        }
    }];
    [self.locationManager stopUpdatingLocation];
}

-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"1");
    searchBar.showsCancelButton = YES;
}
-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"2");
    if ([searchBar.text isEqualToString:@""]) {
        searchBar.showsCancelButton = NO;
    } else {
        searchBar.showsCancelButton = YES;
    }
    self.prevText = nil;
}
-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"3");
    searchBar.text = @"";
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];   //退回键盘
    self.prevText = nil;
}
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"4");
    [searchBar resignFirstResponder];
    NSString *currText = searchBar.text;
    if (currText != nil && ![self.prevText isEqualToString:currText]) {
        [self cityNameDidGet:currText];
    }
    self.prevText = currText;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"hhhhhhhhhh");
}*/

@end
