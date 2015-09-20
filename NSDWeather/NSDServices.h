//
//  NSDServices.h
//  NSDWeather
//
//  Created by David Weldon on 20/09/2015.
//  Copyright (c) 2015 nsdave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDConstants.h"

@class NSDWeather;

@protocol NSDServicesDelegate <NSObject>

@required

- (void)didReceiveWeather:(NSDWeather *)weather;
- (void)didFailWithError:(NSDServiceError)error;

@end

@interface NSDServices : NSObject

+ (id)sharedServices;
- (void)weatherWithDelegate:(id<NSDServicesDelegate>)delegate;

@end