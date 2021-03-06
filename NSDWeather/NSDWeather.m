//
//  NSDWeather.m
//  NSDWeather
//
//  Created by David Weldon on 20/09/2015.
//  Copyright (c) 2015 nsdave. All rights reserved.
//

#import "NSDWeather.h"

@implementation NSDWeather

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    if (self) {
        
        NSDictionary *currentWeatherDictionary = dictionary[@"weather"][@"curren_weather"][0];
        NSDictionary *todayForecastDictionary = dictionary[@"weather"][@"forecast"][0];
        NSDictionary *tomorrowForecastDictionary = dictionary[@"weather"][@"forecast"][1];

        _currentWeather = [[NSDCurrentWeather alloc] initWithDictionary:currentWeatherDictionary];
        _todayForecast = [[NSDForecast alloc] initWithDictionary:todayForecastDictionary];
        _tomorrowForecast = [[NSDForecast alloc] initWithDictionary:tomorrowForecastDictionary];
        
    }
    
    return self;
}

- (instancetype)initWithCurrentWeather:(NSDCurrentWeather *)currentWeather
                         todayForecast:(NSDForecast *)todayForecast
                      tomorrowForecast:(NSDForecast *)tomorrowForecast
{
    self = [super init];
    
    if (self) {
        
        _currentWeather = currentWeather;
        _todayForecast = todayForecast;
        _tomorrowForecast = tomorrowForecast;
        
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@\n%@\n%@",self.currentWeather,
            self.todayForecast,
            self.tomorrowForecast];
}

@end


@implementation NSDCurrentWeather

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {

        _temperature = dictionary[@"temp"];
        _temperatureUnit = dictionary[@"temp_unit"];
        _weatherCode = dictionary[@"weather_code"];
        _weatherText = dictionary[@"weather_text"];
        
    }
    
    return self;
}

- (instancetype)initWithTemperature:(NSString *)temperature
                    temperatureUnit:(NSString *)temperatureUnit
                        weatherCode:(NSString *)weatherCode
                        weatherText:(NSString *)weatherText
{
    self = [super init];
    
    if (self) {
        
        _temperature = temperature;
        _temperatureUnit = temperatureUnit;
        _weatherCode = weatherCode;
        _weatherText = weatherText;
        
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"temperature: %@\ntemperature unit: %@\nweather code: %@\nweather text: %@",self.temperature,
            self.temperatureUnit,
            self.weatherCode,
            self.weatherText];
}

@end


@implementation NSDForecast

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {

        _dayWeatherCode = dictionary[@"day"][0][@"weather_code"];
        _dayWeatherText = dictionary[@"day"][0][@"weather_text"];
        _dayMaxTemperature = dictionary[@"day_max_temp"];
        _nightWeatherCode = dictionary[@"night"][0][@"weather_code"];
        _nightWeatherText = dictionary[@"night"][0][@"weather_text"];
        _nightMinTemperature = dictionary[@"night_min_temp"];
        _temperatureUnit = dictionary[@"temp_unit"];
        
    }
    
    return self;
}

- (instancetype)initWithDayWeatherCode:(NSString *)dayWeatherCode
                        dayWeatherText:(NSString *)dayWeatherText
                     dayMaxTemperature:(NSString *)dayMaxTemperature
                      nightWeatherCode:(NSString *)nightWeatherCode
                      nightWeatherText:(NSString *)nightWeatherText
                   nightMinTemperature:(NSString *)nightMinTemperature
                       temperatureUnit:(NSString *)temperatureUnit
{
    self = [super init];
    
    if (self) {
        
        _dayWeatherCode = dayWeatherCode;
        _dayWeatherText = dayWeatherText;
        _dayMaxTemperature = dayMaxTemperature;
        _nightWeatherCode = nightWeatherCode;
        _nightWeatherText = nightWeatherText;
        _nightMinTemperature = nightMinTemperature;
        _temperatureUnit = temperatureUnit;

    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"day weather code: %@\nday weather text: %@\nday max temperature:%@\nnight weather code: %@\nnight weather text: %@\nnight min temperature: %@\ntemperature unit: %@",self.dayWeatherCode,
            self.dayWeatherText,
            self.dayMaxTemperature,
            self.nightWeatherCode,
            self.nightWeatherText,
            self.nightMinTemperature,
            self.temperatureUnit];
}

@end

