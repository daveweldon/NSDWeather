//
//  ViewController.m
//  NSDWeather
//
//  Created by David Weldon on 20/09/2015.
//  Copyright (c) 2015 nsdave. All rights reserved.
//

#import "NSDHomeViewController.h"
#import "NSDServices.h"
#import "MBProgressHUD.h"
#import "TWMessageBarManager.h"

@interface NSDHomeViewController () <NSDServicesDelegate>

@end

@implementation NSDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // get the weather
    [[NSDServices sharedServices] weatherWithDelegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSDServicesDelegate methods -

- (void)didReceiveWeather:(id)products
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    NSLog(@"products: %@",products);
}

- (void)didFailWithError:(NSDServiceError)error
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    switch (error) {
        case NSDServiceErrorNoNetwork:
            
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:NSLocalizedString(@"MESAGE_TITLE_INFO", @"")
                                                           description:NSLocalizedString(@"MESAGE_DETAIL_NO_NETWORK", @"")
                                                                  type:TWMessageBarMessageTypeInfo
                                                              duration:kErrorMessageDuration];
            
            break;
            
        case NSDServiceErrorJSONParsing:
        case NSDServiceErrorConnection:
        case NSDServiceErrorNoHost:
            
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:NSLocalizedString(@"MESAGE_TITLE_ERROR", @"")
                                                           description:NSLocalizedString(@"MESAGE_DETAIL_ERROR_RETRIEVING_DATA", @"")
                                                                  type:TWMessageBarMessageTypeError
                                                              duration:kErrorMessageDuration];

            break;
            
        default:
            break;
    }
    
}

@end
