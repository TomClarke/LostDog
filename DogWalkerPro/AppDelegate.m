//
//  AppDelegate.m
//  DogWalkerPro
//
//  Created by Thomas Clarke on 23/06/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
#import "MissingDogsViewController.h"
#import "MasterViewController.h"
#import "InputViewController.h"
#import "MainMenuViewController.h"



@implementation AppDelegate

//@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
    [Parse setApplicationId:@"NtFAPxv8LmzhKUQ16CgYi62twBNHypYLFfAcLQKc"
                  clientKey:@"U7qhHqNJtJ8jAINa66ldiFCLAyk8BKQIQkwgTgij"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    // Override point for customization after application launch.
    
    
    
    return YES;
}

// In the app delegate we create a constant string to be used as an event name
static NSString* const kPAWLocationChangeNotification= @"kPAWLocationChangeNotification";

// We also add a method to be called when the location changes.
// This is where we post the notification to all observers.
- (void)setCurrentLocation:(CLLocation *)aCurrentLocation
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject: aCurrentLocation
                                                         forKey:@"location"];
    [[NSNotificationCenter defaultCenter] postNotificationName: kPAWLocationChangeNotification
                                                        object:nil
                                                      userInfo:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  
    
    // [[SDSyncEngine sharedEngine] startSync];
   
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  

}
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
