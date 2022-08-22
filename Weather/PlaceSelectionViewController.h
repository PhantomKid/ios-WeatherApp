//
//  PlaceSelectionViewController.h
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import <UIKit/UIKit.h>
#import "WeatherData.h"

NS_ASSUME_NONNULL_BEGIN

@interface MySearchBar : UISearchBar <UISearchBarDelegate>
@property(weak) WeatherData *weatherData;
@property(atomic, nullable, copy) NSString *prevText;
-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar;
-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar;
-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar;
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar;
@end

@interface PlaceSelectionViewController : UIViewController
@property(weak) WeatherData *weatherData;
@property(weak) IBOutlet MySearchBar *citySearchBar;
@end

NS_ASSUME_NONNULL_END
