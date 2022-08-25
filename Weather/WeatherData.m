//
//  WeatherData.m
//  Weather
//
//  Created by Kai on 2022/8/16.
//

#import <Foundation/Foundation.h>
#import "WeatherData.h"

#define COPYBEFOREINIT(TYPE) TYPE *copy = [[TYPE allocWithZone:zone] init];

static const NSString *key = @"160598640a6f42ebbc584183a10b5a70";

@implementation WeatherBasicClass
-(NSString *) toString {
    return @"WeatherBasicClass";
}
-(void) print {
    NSLog(@"%@", [self toString]);
}
-(void) decodeJsonDictionary: (NSDictionary *_Nonnull) jsonData {
    NSLog(@"WeatherBasicClass DecodeJsonDictionary");
}
-(instancetype)copyWithZone:(nullable NSZone *)zone {
    COPYBEFOREINIT(WeatherBasicClass);
    return copy;
}

@end

@implementation WeatherIndex
-(instancetype) init {
    self = [super init];
    if (self) {
        _name = nil;
        _text = nil;
        _category = nil;
    }
    return self;
}
-(NSString *) toString {
    NSString *str = [[NSString alloc] initWithFormat:@"%@:%@\n评价:%@", self.name, self.category, self.text];
    return str;
}
-(void) decodeJsonDictionary:(NSDictionary *)jsonData {
    self.name = jsonData[@"name"];
    self.text = jsonData[@"text"];
    self.category = jsonData[@"category"];
}
-(instancetype)copyWithZone:(NSZone *)zone {
    COPYBEFOREINIT(WeatherIndex);
    copy.name = self.name;
    copy.text = self.text;
    copy.category = self.category;
    return copy;
}
@end

@implementation SimpleWeatherData
-(instancetype) init {
    self = [super init];
    if (self) {
        _text = nil;
        _iconCode = 0;
        _tempMax = 0;
        _tempMin = 0;
    }
    return self;
}
-(NSString *) toString {
    NSString *str = [[NSString alloc] initWithFormat:@"天气:%@,天气图标代码:%ld,最高温度为%ld,最低温度为%ld", self.text, self.iconCode, self.tempMax, self.tempMin];
    return str;
}
-(instancetype) copyWithZone:(NSZone *)zone {
    COPYBEFOREINIT(SimpleWeatherData);
    copy.text = self.text;
    copy.iconCode = self.iconCode;
    copy.tempMax = self.tempMax;
    copy.tempMin = self.tempMin;
    return self;
}
-(void) decodeJsonDictionary:(NSDictionary *)jsonData {
    self.text = jsonData[@"textDay"];
    self.iconCode = [jsonData[@"iconDay"] intValue];
    self.tempMax = [jsonData[@"tempMax"] intValue];
    self.tempMin = [jsonData[@"tempMin"] intValue];
}
@end

@implementation WeatherData
-(instancetype) copyWithZone:(NSZone *)zone {
    COPYBEFOREINIT(WeatherData);
    copy.cityName = self.cityName;
    copy.updateTime = self.updateTime;
    copy.text = self.text;
    copy.iconCode = self.iconCode;
    copy.temp = self.temp;
    copy.humidity = self.humidity;
    copy.pressure = self.pressure;
    copy.windDir = self.windDir;
    copy.windScale = self.windScale;
    copy.windSpeed = self.windSpeed;
    copy.sportIndex = self.sportIndex;
    copy.comfortIndex = self.comfortIndex;
    copy.makeupIndex = self.makeupIndex;
    copy.weekForcastData = self.weekForcastData;
    return copy;
}
-(instancetype) init {
    self = [super init];
    if (self) {
        _cityName = nil;
        _cityName = nil;
        _updateTime = nil;
        _text = nil;
        _iconCode = 0;
        _temp = nil;
        _humidity = 0;
        _pressure = 0;
        _windDir = nil;
        _windScale = 0;
        _windSpeed = 0;
        _comfortIndex = [[WeatherIndex alloc] init];
        _sportIndex = [[WeatherIndex alloc] init];
        _makeupIndex = [[WeatherIndex alloc] init];
        SimpleWeatherData *day0 = [[SimpleWeatherData alloc] init];
        SimpleWeatherData *day1 = [[SimpleWeatherData alloc] init];
        SimpleWeatherData *day2 = [[SimpleWeatherData alloc] init];
        /*SimpleWeatherData *day3 = [[SimpleWeatherData alloc] init];
        SimpleWeatherData *day4 = [[SimpleWeatherData alloc] init];
        SimpleWeatherData *day5 = [[SimpleWeatherData alloc] init];
        SimpleWeatherData *day6 = [[SimpleWeatherData alloc] init];*/
        _weekForcastData = [[NSMutableArray alloc] initWithObjects:day0, day1, day2,/* day3, day4, day5, day6, */nil];
    }
    return self;
}
-(NSString *) toString {
    NSString *str = [[NSString alloc] initWithFormat:@"数据更新时间:%@, 地点:%@, 天气:%@, 天气图标代号:%ld, 温度:%@, 湿度:%@, 气压:%@, 风向:%@, 风力:%@, 风速:%@", self.updateTime, self.cityName, self.text, self.iconCode, self.temp, self.humidity, self.pressure, self.windDir, self.windScale, self.windSpeed];
    return str;
}
-(NSString *) getDate {
    return [self.updateTime substringToIndex:10];
}
-(void) decodeJsonDictionary:(NSDictionary *)jsonDictionary {
    NSString *rowUpdateTime = jsonDictionary[@"updateTime"];
    NSRange range = NSMakeRange(11, 5);
    if ([rowUpdateTime length] != 22) {
        NSLog(@"rowUpdateTime = %@", rowUpdateTime);
    } else {
        self.updateTime = [[NSString alloc] initWithFormat:@"%@ %@", [rowUpdateTime substringToIndex:10], [rowUpdateTime substringWithRange:range]];
    }
    id nowPart = jsonDictionary[@"now"];
    if ([nowPart isKindOfClass:[NSDictionary class]] && nowPart != nil) {
        self.text = nowPart[@"text"];
        self.iconCode = [nowPart[@"icon"] intValue];
        self.temp = nowPart[@"temp"];
        self.humidity = nowPart[@"humidity"];
        self.pressure = nowPart[@"pressure"];
        self.windDir = nowPart[@"windDir"];
        self.windSpeed = nowPart[@"windSpeed"];
        self.windScale = nowPart[@"windScale"];
    }
}
-(void) decodeJsonDictionaryForIndice:(NSDictionary *)jsonData {
    NSArray *daily = jsonData[@"daily"];
    for (int i = 0; i < daily.count; ++i) {
        switch (i) {
            case 0:
                [self->_sportIndex decodeJsonDictionary:[daily objectAtIndex:i]];
                break;
            case 1:
                [self->_comfortIndex decodeJsonDictionary:[daily objectAtIndex:i]];
            case 2:
                [self->_makeupIndex decodeJsonDictionary:[daily objectAtIndex:i]];
            default:
                break;
        }
    }
}
-(void) decodeJsonDictionaryForForcast:(NSDictionary *)jsonData {
    NSArray *daily = jsonData[@"daily"];
    for (NSUInteger i = 0; i < 3; ++i) {
        [[_weekForcastData objectAtIndex:i] decodeJsonDictionary:[daily objectAtIndex:i]];
    }
}
-(void) getlocationID:(void (^)(NSString * _Nullable))callBack {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"https://geoapi.qweather.com/v2/city/lookup?";
    NSString *formattedURL = [[NSString alloc] initWithFormat:@"%@location=%@&key=%@", url, self.cityName, key];
    NSString *__block locationID = nil;
    NSString *utf8URL = [formattedURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    @try {
        [manager GET:utf8URL parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseData) {
            if ([responseData isKindOfClass:[NSDictionary class]] && responseData != nil) {
                id locationPart = responseData[@"location"];
                if ([locationPart isKindOfClass:[NSDictionary class]] && locationPart != nil) {
                    locationID = [[NSString alloc] initWithString:locationPart[@"id"]];
                    callBack(locationID);
                } else if ([locationPart isKindOfClass:[NSArray class]] && locationPart != nil) {
                    id dictionaryInsideArray = [locationPart objectAtIndex:0];
                    if ([dictionaryInsideArray isKindOfClass:[NSDictionary class]] && dictionaryInsideArray != nil) {
                        locationID = [[NSString alloc] initWithString:dictionaryInsideArray[@"id"]];
                        callBack(locationID);
                    } else {
                        NSLog(@"Not a dictionary inside an array");
                    }
                } else {
                    NSLog(@"Not dictionary or array");
                    NSLog(@"locationPart:%@", locationPart);
                    NSLog(@"locationPart is of class: %@", [locationPart class]);
                }
            } else {
                NSLog(@"getlocationIDTypeError");
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"getlocationIDError: %@", error);
        }];
    } @catch (NSException *exc) {
        NSLog(@"%@, %@", exc, [exc name]);
    }
}
-(void) getDataOnline:(NSString *)url :(NSString *(^)(NSString *, NSString *))formatBlock :(void(^)(NSDictionary *))decodeBlock
{
    void (^_Nonnull getBack)(NSString *_Nullable locationID) = ^void(NSString *_Nullable locationID) {
        if (locationID == nil) {
            NSLog(@"self.locationID is nil");
            return;
        }
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *formattedURL = formatBlock(url, locationID);
        @try {
            [manager GET:formattedURL parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseData) {
                if ([responseData isKindOfClass:[NSDictionary class]] && responseData != nil) {
                    decodeBlock(responseData);
                } else if ([responseData isKindOfClass:[NSArray class]] && responseData != nil) {
                    id dictionaryInsideArray = [responseData objectAtIndex:0];
                    if ([dictionaryInsideArray isKindOfClass:[NSDictionary class]] && dictionaryInsideArray != nil) {
                        decodeBlock(responseData);
                    } else {
                        NSLog(@"Not a dictionary inside an array");
                    }
                } else {
                    NSLog(@"Not dictionary or array");
                }
            } failure: ^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"getWeatherDataOnlineError: %@", error);
            }];
        } @catch (NSException *exc){
            NSLog(@"%@, %@", exc, [exc name]);
        }
    };
    [self getlocationID:getBack];
}
-(void) getWeatherDataOnline {
    NSString *url = @"https://devapi.qweather.com/v7/weather/now?";
    NSString *(^formatBlock)(NSString *, NSString *) = ^NSString *(NSString *url, NSString *locationID) {
        NSString *formattedURL = [[NSString alloc] initWithFormat:@"%@location=%@&key=%@", url, locationID, key];
        return formattedURL;
    };
    void (^decodeBlock)(NSDictionary *) = ^void(NSDictionary* jsonData) {
        [self decodeJsonDictionary:jsonData];
        NSNotification *notification = [[NSNotification alloc] initWithName:@"weatherDataDidGet" object:nil userInfo:@{@"key":self}];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    };
    [self getDataOnline:url :formatBlock :decodeBlock];
}
-(void) getWeatherIndiceOnline {
    NSString *url = @"https://devapi.qweather.com/v7/indices/1d?";
    NSString *(^formatBlock)(NSString *, NSString *) = ^NSString *(NSString *url, NSString *locationID) {
        NSString *formattedURL = [[NSString alloc] initWithFormat:@"%@type=1,8,13&location=%@&key=%@", url, locationID, key];
        return formattedURL;
    };
    void (^decodeBlock)(NSDictionary *) = ^void(NSDictionary* jsonData) {
        [self decodeJsonDictionaryForIndice:jsonData];
        NSNotification *notification = [[NSNotification alloc] initWithName:@"weatherIndiceDidGet" object:nil userInfo:@{@"key":self}];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    };
    [self getDataOnline:url :formatBlock :decodeBlock];
}
-(void) getWeekForcastDataOnline {
    //NSString *url = @"https://devapi.qweather.com/v7/weather/7d?";
    NSString *url = @"https://devapi.qweather.com/v7/weather/3d?";
    NSString *(^formatBlock)(NSString *, NSString *) = ^NSString *(NSString *url, NSString *locationID) {
        NSString *formattedURL = [[NSString alloc] initWithFormat:@"%@location=%@&key=%@", url, locationID, key];
        return formattedURL;
    };
    void (^decodeBlock)(NSDictionary *) = ^void(NSDictionary* jsonData) {
        [self decodeJsonDictionaryForForcast:jsonData];
        NSNotification *notification = [[NSNotification alloc] initWithName:@"weatherWeekForcastDidGet" object:nil userInfo:@{@"key":self}];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    };
    [self getDataOnline:url :formatBlock :decodeBlock];
}
@end

@implementation UIViewControllerWithWeatherData
-(instancetype) init {
    self = [super init];
    if (self) {
        WeatherData * __strong wd = [[WeatherData alloc] init];
        self.weatherData = wd;
    }
    return self;
}
@end
