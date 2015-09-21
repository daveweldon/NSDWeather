//
//  NSDMockData.m
//  NSDWeather
//
//  Created by David Weldon on 21/09/2015.
//  Copyright (c) 2015 nsdave. All rights reserved.
//

#import "NSDMockData.h"
#import "NSDWeather.h"

@implementation NSDMockData

+ (NSDWeather *)weather
{
    NSDCurrentWeather *currentWeather = [[NSDCurrentWeather alloc] initWithTemperature:@"10"
                                                                       temperatureUnit:@"c"
                                                                           weatherCode:@"1"
                                                                           weatherText:@"Sunny"];
    
    NSDForecast *todayForecast = [[NSDForecast alloc] initWithDayWeatherCode:@"2"
                                                              dayWeatherText:@"Cloudy"
                                                           dayMaxTemperature:@"7"
                                                            nightWeatherCode:@"3"
                                                            nightWeatherText:@"Foggy"
                                                         nightMinTemperature:@"1"
                                                             temperatureUnit:@"c"];

    NSDForecast *tomorrowForecast = [[NSDForecast alloc] initWithDayWeatherCode:@"3"
                                                                 dayWeatherText:@"Rain"
                                                              dayMaxTemperature:@"15"
                                                               nightWeatherCode:@"2"
                                                               nightWeatherText:@"Dry"
                                                            nightMinTemperature:@"7"
                                                                temperatureUnit:@"c"];

    NSDWeather *weather = [[NSDWeather alloc] initWithCurrentWeather:currentWeather
                                                       todayForecast:todayForecast
                                                    tomorrowForecast:tomorrowForecast];
    
    return weather;
}

@end
