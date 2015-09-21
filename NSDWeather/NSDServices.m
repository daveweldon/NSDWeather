//
//  NSDServices.m
//  NSDWeather
//
//  Created by David Weldon on 20/09/2015.
//  Copyright (c) 2015 nsdave. All rights reserved.
//

#import "NSDServices.h"
#import "Reachability.h"
#import "NSDWeather.h"
#import "NSDMockData.h"

@implementation NSDServices

+ (instancetype)sharedServices
{
    static NSDServices *sharedMyServices = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyServices = [[self alloc] init];
    });
    
    return sharedMyServices;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

#pragma mark - public methods

- (void)weatherWithDelegate:(id<NSDServicesDelegate>)delegate;
{
    
#ifdef IS_MOCK_MODE
    
    if ([delegate respondsToSelector:@selector(didReceiveWeather:)]) {
        
        // create mock object to return
        NSDWeather *mockWeather = [NSDMockData weather];
        
        [delegate didReceiveWeather:mockWeather];
        
    }

#else
    
    Reachability *reach = [Reachability reachabilityWithHostname:kARGServicesHost];
    
    if (![reach isReachable]) {
        
        // display an error
        if ([delegate respondsToSelector:@selector(didFailWithError:)]) {
            
            [delegate didFailWithError:NSDServiceErrorNoHost];

        }
        
        return;
    }
    
    // TODO: Make the postcode dynamic
    NSString *urlString = [NSString stringWithFormat:@"http://%@%@?uac=%@&output=%@&query=gu513ls",
                           kARGServicesHost,
                           kARGServices2DayForecastEndpoint,
                           kARGServicesUniqueAccessCode,
                           kARGServicesOutput];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *connectionError) {
                               
                               // we can assume an http response, if we know thats what we've requested
                               NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                               
                               // get the data we're after
                               if (httpResponse.statusCode == 200) {
                                   
                                   if ([delegate respondsToSelector:@selector(didReceiveWeather:)]) {
                                       
                                       NSError *error;
                                       NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                            options:kNilOptions
                                                                                              error:&error];
                                       
                                       if (error) {
                                           
                                           if ([delegate respondsToSelector:@selector(didFailWithError:)]) {
                                               
                                               [delegate didFailWithError:NSDServiceErrorJSONParsing];
                                               
                                           }
                                           
                                       } else {
                                           
                                           NSDWeather *weather = [[NSDWeather alloc] initWithDictionary:json];
                                           
                                           [delegate didReceiveWeather:weather];
                                           
                                       }
                                       
                                   }
                                   
                               } else {
                                   
                                   if ([delegate respondsToSelector:@selector(didFailWithError:)]) {
                                       
                                       [delegate didFailWithError:NSDServiceErrorConnection];
                                       
                                   }
                                   
                               }
                               
                           }];
    
#endif

}

@end
