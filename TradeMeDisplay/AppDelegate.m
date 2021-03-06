//
//  AppDelegate.m
//  TradeMeDisplay
//
//  Created by Charles on 4/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "AppDelegate.h"
#import "TMDListingTableViewController.h"
#import "TMDCategoryTableViewController.h"
#import "TMDListingDetailTableViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *listingNavigationController = splitViewController.viewControllers.lastObject;
    listingNavigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Split view delegate

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *topViewController  = ((UINavigationController *)secondaryViewController).topViewController;
        if ([topViewController isKindOfClass:[TMDListingTableViewController class]]) {
            TMDListingTableViewController *listTableViewController = (TMDListingTableViewController *)topViewController;
            if(listTableViewController.dataSource.count > 0) {
                return NO;
            }
        } else if([topViewController isKindOfClass:[TMDListingDetailTableViewController class]]) {
            TMDListingDetailTableViewController *listDetailTableViewController = (TMDListingDetailTableViewController *)topViewController;
            if(listDetailTableViewController.detail) {
                return NO;
            }
        }
    }
    
    return YES;
}


@end
