//
//  VLMAppDelegate.m
//  DuellingTableViews
//
//  Created by David Lu on 1/4/13.
//  Copyright (c) 2013 David Lu. All rights reserved.
//

#import "VLMAppDelegate.h"

#import "VLMViewController.h"

@implementation VLMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Override point for customization after application launch.
    
    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_light.png"]];
    UIView *colorfield = [[UIView alloc] initWithFrame:self.window.frame];
    [colorfield setUserInteractionEnabled:NO];
    [colorfield setBackgroundColor:[UIColor colorWithHue:26.0f/360.0f saturation:0.8f brightness:0.95f alpha:0.075f]];
    [self.window addSubview:colorfield];
    
    self.viewController = [[VLMViewController alloc] initWithNibName:@"VLMViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
