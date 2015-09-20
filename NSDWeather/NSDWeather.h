//
//  NSDWeather.h
//  NSDWeather
//
//  Created by David Weldon on 20/09/2015.
//  Copyright (c) 2015 nsdave. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSDCurrentWeather;
@class NSDForecast;

@interface NSDWeather : NSObject

@property (nonatomic, strong) NSDCurrentWeather *currentWeather;
@property (nonatomic, strong) NSDForecast *todayForecast;
@property (nonatomic, strong) NSDForecast *tomorrowForecast;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface NSDCurrentWeather : NSObject

//"temp":"19",
//"temp_unit":"c",
//"weather_code":"1",
//"weather_text":"Mostly cloudy",

@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *temperatureUnit;
@property (nonatomic, strong) NSString *weatherCode;
@property (nonatomic, strong) NSString *weatherText;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface NSDForecast : NSObject

//"weather_code":"0",
//"weather_text":"Sunny skies",
//"day_max_temp":"20",
//"night_min_temp":"10",
//"temp_unit":"c"

@property (nonatomic, strong) NSString *dayWeatherCode;
@property (nonatomic, strong) NSString *dayWeatherText;
@property (nonatomic, strong) NSString *dayMaxTemperature;
@property (nonatomic, strong) NSString *nightWeatherCode;
@property (nonatomic, strong) NSString *nightWeatherText;
@property (nonatomic, strong) NSString *nightMinTemperature;
@property (nonatomic, strong) NSString *temperatureUnit;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


