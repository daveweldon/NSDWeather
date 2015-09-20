//
//  NSDConstants.h
//  NSDWeather
//
//  Created by David Weldon on 20/09/2015.
//  Copyright (c) 2015 nsdave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDConstants : NSObject

extern CGFloat kErrorMessageDuration;

extern NSString * const kARGServicesHost;
extern NSString * const kARGServices2DayForecastEndpoint;
extern NSString * const kARGServicesUniqueAccessCode;
extern NSString * const kARGServicesOutput;

typedef NS_ENUM(NSInteger, NSDServiceError)  {
    NSDServiceErrorNoNetwork,
    NSDServiceErrorJSONParsing,
    NSDServiceErrorConnection,
    NSDServiceErrorNoHost
};

@end
