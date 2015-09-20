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
#import "NSDWeather.h"

@interface NSDHomeViewController () <NSDServicesDelegate>

// although these are outlets, they need to be strong so that they aren't lost
// when they become inactive
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *todayHeightLayoutConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *tomorrowHeightLayoutConstraint;

@property (nonatomic, weak) IBOutletCollection(UILabel) NSArray *labelArray;

@property (nonatomic, weak) IBOutlet UIButton *tomorrowButton;
@property (nonatomic, weak) IBOutlet UILabel *postcodeLabel;
@property (nonatomic, weak) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *weatherTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *todayDayTemperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *todayDayTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *todayNightTemperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *todayNightTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *tomorrowDayTemperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *tomorrowDayTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *tomorrowNightTemperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *tomorrowNightTextLabel;

@end

@implementation NSDHomeViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self didPressExpandButton:self.tomorrowButton
                      animated:NO];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    
    // get the weather
    [[NSDServices sharedServices] weatherWithDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSDServicesDelegate methods -

- (void)didReceiveWeather:(NSDWeather *)weather
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    
    self.postcodeLabel.text = @"GU51 3LS";
    self.temperatureLabel.text = [NSString stringWithFormat:@"Temperature: %@ %@",weather.currentWeather.temperature,
                                  weather.currentWeather.temperatureUnit];
    self.weatherTextLabel.text = [NSString stringWithFormat:@"%@",weather.currentWeather.weatherText];
    
    self.todayDayTemperatureLabel.text = [NSString stringWithFormat:@"Temperature: %@ %@",weather.todayForecast.dayMaxTemperature,
                                          weather.todayForecast.temperatureUnit];
    self.todayDayTextLabel.text = [NSString stringWithFormat:@"%@",weather.todayForecast.dayWeatherText];
    self.todayNightTemperatureLabel.text = [NSString stringWithFormat:@"Temperature: %@ %@",weather.todayForecast.nightMinTemperature,
                                            weather.todayForecast.temperatureUnit];
    self.todayNightTextLabel.text = [NSString stringWithFormat:@"%@",weather.todayForecast.nightWeatherText];
    self.tomorrowDayTemperatureLabel.text = [NSString stringWithFormat:@"Temperature: %@ %@",weather.tomorrowForecast.dayMaxTemperature,
                                             weather.tomorrowForecast.temperatureUnit];
    self.tomorrowDayTextLabel.text = [NSString stringWithFormat:@"%@",weather.tomorrowForecast.dayWeatherText];
    self.tomorrowNightTemperatureLabel.text = [NSString stringWithFormat:@"Temperature: %@ %@",weather.tomorrowForecast.nightMinTemperature,
                                               weather.tomorrowForecast.temperatureUnit];
    self.tomorrowNightTextLabel.text = [NSString stringWithFormat:@"%@",weather.tomorrowForecast.nightWeatherText];

    [self displayLabels:YES animated:YES];
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

#pragma mark - Private methods -

- (void)displayLabels:(BOOL)display animated:(BOOL)animated
{
    CGFloat animationDuration = (animated) ? 0.5f : 0.0f;
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        for (UILabel *label in self.labelArray) {
            
            label.alpha = (display) ? 1.0f : 0.0f;
            
        }
        
    }];

}

- (void)didPressExpandButton:(UIButton *)button animated:(BOOL)animated
{
    CGFloat animationDuration = (animated) ? 0.5f : 0.0f;
    NSLayoutConstraint *sectionHeightConstraint;
    
    if (0 == button.tag) {
        
        sectionHeightConstraint = self.todayHeightLayoutConstraint;
        
    } else {
        
        sectionHeightConstraint = self.tomorrowHeightLayoutConstraint;
        
    }
    
    sectionHeightConstraint.active = button.selected;
    button.selected = !button.selected;
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        [button.superview layoutIfNeeded];
        [self.view layoutIfNeeded];
        
    }];

}

- (IBAction)didPressExpandButton:(UIButton *)button
{
    [self didPressExpandButton:button animated:YES];
}

@end
