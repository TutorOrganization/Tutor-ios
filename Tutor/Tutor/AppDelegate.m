//
//  AppDelegate.m
//  Tutor
//
//  Created by syzhou on 13-10-28.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "AppDelegate.h"

#import "WelcomeViewController.h"
#import "TutorDataProvider.h"

#define Test 1

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    WelcomeViewController *loginViewCol = [[WelcomeViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewCol];
    self.window.rootViewController = navigationController;
    navigationController.navigationBarHidden = YES;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if (Test) {
        [self testReruest];
    }
    
    
    return YES;
}

- (void)testReruest {
    BACK(^{
//        [TutorDataProvider registeWithMobile:@"18621103111" password:@"111111" handle:^(SYRequest *request) {
//            DLog(@"register:%@",request.responseString);
//
//        }];
        [TutorDataProvider registeWithMobile:@"18621103111" password:@"1111115" handle:^(SYRequest *request) {
            DLog(@"register:%@",request.responseString);
            
        }];
    });
    
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
