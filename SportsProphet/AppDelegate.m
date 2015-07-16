//
//  AppDelegate.m
//  SportsProphet
//
//  Created by Vik Denic on 7/7/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import "AppDelegate.h"
#import <ParseCrashReporting/ParseCrashReporting.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [ParseCrashReporting enable];
    [Team registerSubclass];
    [Player registerSubclass];
    
    [self parseSetup];

//    [self sportsAPITokenRetrieval];

    return YES;
}

-(void)parseSetup
{
    //Private Keys in Keys.plist (hidden via gitignore)
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Keys" ofType:@"plist"]];
    NSString *applicationId = [dictionary objectForKey:@"ParseAppID"];
    NSString *clientKey = [dictionary objectForKey:@"ParseClientKey"];

    [Parse setApplicationId:applicationId
                  clientKey:clientKey];
}

-(void)sportsAPITokenRetrieval
{
    [PFConfig getConfigInBackgroundWithBlock:^(PFConfig *config, NSError *error) {

        if (error == nil)
        {
            NSString *token = config[@"xmlstatsToken"];
            [UniversalToken sharedInstance].token = token;
            NSLog(@"xmlstats token: %@", token);
        }
        else
        {
            NSLog(@"%@", error);
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
