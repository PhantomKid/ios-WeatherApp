//
//  PlaceSelectionViewController.m
//  Weather
//
//  Created by Kai on 2022/8/21.
//

#import "PlaceSelectionViewController.h"

@implementation MySearchBar
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
}
-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"3");
    searchBar.text = @"";
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];   //退回键盘
}
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"4");
    [searchBar resignFirstResponder];
    NSString *currText = searchBar.text;
    if (currText != nil && ![self.prevText isEqualToString:currText]) {
        self.weatherData.cityName = currText;
        [self.weatherData getWeatherDataOnline];
        [self.weatherData getWeatherIndiceOnline];
        [self.weatherData getWeekForcastDataOnline];
    }
    self.prevText = currText;
}
@end

@interface PlaceSelectionViewController ()

@end

@implementation PlaceSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.citySearchBar.weatherData = self.weatherData;
    self.citySearchBar.delegate = self.citySearchBar;
    [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].title = @"取消";
    self.citySearchBar.prevText = nil;
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
