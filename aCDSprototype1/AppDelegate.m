//
//  AppDelegate.m
//  aCDSprototype1
//
//  Created by Erik on 3/5/15.
//  Copyright (c) 2015 FWS. All rights reserved.
//

#import "AppDelegate.h"
#import "Screen.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Initialize fullscreen window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UIViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    // Initialize the screen
    [Screen initWithWindow:self.window];
    return YES;
}

@end
