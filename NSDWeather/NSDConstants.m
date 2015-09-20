//
//  NSDConstants.m
//  NSDWeather
//
//  Created by David Weldon on 20/09/2015.
//  Copyright (c) 2015 nsdave. All rights reserved.
//

#import "NSDConstants.h"

@implementation NSDConstants

CGFloat kErrorMessageDuration = 6.0;

// services (e.g. http://www.myweather2.com/developer/forecast.ashx?uac=zNvg1bv0bR&output=json&query=SW1)
NSString * const kARGServicesHost = @"www.myweather2.com";
NSString * const kARGServices2DayForecastEndpoint = @"/developer/forecast.ashx";
NSString * const kARGServicesUniqueAccessCode = @"zNvg1bv0bR";
NSString * const kARGServicesOutput = @"json";

@end
