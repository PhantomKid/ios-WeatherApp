//
//  WeatherData.h
//  Weather
//
//  Created by Kai on 2022/8/16.
//

#ifndef WeatherData_h
#define WeatherData_h

#import <AFNetworking.h>

@protocol WeatherBasicClass <NSObject, NSCopying>
@required
-(NSString *_Nonnull) toString;
@optional
-(void) decodeJsonDictionary:(NSDictionary *_Nonnull) jsonData;
@end

@interface WeatherBasicClass : NSObject <WeatherBasicClass>
-(void) print;
@end

@interface WeatherIndex : WeatherBasicClass
@property(nonatomic, nonnull, copy) NSString *name;
@property(nonatomic, nonnull, copy) NSString *text;
@property(nonatomic, nonnull, copy) NSString *category;
-(instancetype _Nonnull) init;
@end

@interface SimpleWeatherData : WeatherBasicClass
@property(nonatomic, nonnull, copy) NSString *date;
@property(nonatomic, nonnull, copy) NSString *textDay;
@property(nonatomic, nonnull, copy) NSString *textNight;
@property(nonatomic, nonnull, copy) NSString *windDirDay;
@property(nonatomic, nonnull, copy) NSString *windDirNight;
@property(nonatomic, nonnull, copy) NSString *windScaleDay;
@property(nonatomic, nonnull, copy) NSString *windScaleNight;
@property(nonatomic, nonnull, copy) NSString *windSpeedDay;
@property(nonatomic, nonnull, copy) NSString *windSpeedNight;
@property(nonatomic, assign) NSInteger iconCodeDay;
@property(nonatomic, assign) NSInteger iconCodeNight;
@property(nonatomic, assign) NSInteger tempMax;
@property(nonatomic, assign) NSInteger tempMin;
-(instancetype _Nonnull) init;
@end

@interface WeatherData : WeatherBasicClass
@property(nonatomic, nonnull, copy) NSString *cityName;
@property(nonatomic, nonnull, copy) NSString *updateTime;
@property(nonatomic, nonnull, copy) NSString *text;
@property(nonatomic, assign) NSInteger iconCode;
@property(nonatomic, nonnull, copy) NSString *temp;
@property(nonatomic, nonnull, copy) NSString *humidity;
@property(nonatomic, nonnull, copy) NSString *pressure;
@property(nonatomic, nonnull, copy) NSString *windDir;
@property(nonatomic, nonnull, copy) NSString *windScale;
@property(nonatomic, nonnull, copy) NSString *windSpeed;
@property(nonatomic, nonnull, copy) WeatherIndex *comfortIndex;
@property(nonatomic, nonnull, copy) WeatherIndex *sportIndex;
@property(nonatomic, nonnull, copy) WeatherIndex *makeupIndex;
@property(nonatomic, nonnull, copy) NSMutableArray<SimpleWeatherData*> *weekForcastData;
-(instancetype _Nonnull) init;
-(NSString *_Nonnull) getDate;
-(void) decodeJsonDictionary:(NSDictionary *_Nonnull)jsonData;
-(void) decodeJsonDictionaryForIndice:(NSDictionary *_Nonnull)jsonData;
-(void) decodeJsonDictionaryForForcast:(NSDictionary *_Nonnull)jsonData;
-(void) getlocationID: (void(^_Nonnull)(NSString *_Nullable))callBack;
-(void) getWeatherDataOnline;
-(void) getWeatherIndiceOnline;
-(void) getWeekForcastDataOnline;
@end

@interface WeatherData()
-(void) getDataOnline:(NSString *_Nonnull)url :(NSString *_Nonnull(^_Nonnull)(NSString *_Nonnull, NSString *_Nonnull))formatBlock :(void (^_Nonnull)(NSDictionary * _Nonnull))decodeBlock;
@end

#endif /* WeatherData_h */
