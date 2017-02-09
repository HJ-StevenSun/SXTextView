//
//  AppDelegate.m
//  textview
//
//  Created by Steven on 17/2/6.
//  Copyright © 2017年 Steven. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //    控制整个功能是否启用。
    manager.enable = YES;
    manager.overrideKeyboardAppearance = YES;
    //控制点击背景是否收起键盘
    manager.shouldResignOnTouchOutside = YES;
    //    //控制键盘上的工具条文字颜色是否用户自定义。  注意这个颜色是指textfile的tintcolor
    //    manager.shouldToolbarUsesTextFieldTintColor = YES;
    //    //中间位置是否显示占位文字(默认是YES)
    //    manager.shouldShowTextFieldPlaceholder = YES;
    //    //设置占位文字的字体大小
    manager.placeholderFont = [UIFont boldSystemFontOfSize:18];
    //控制是否显示键盘上的工具条。
    manager.enableAutoToolbar = YES;
    //某个类中禁止使用工具条
    //    [[IQKeyboardManager sharedManager]disableToolbarInViewControllerClass:[UIViewController class]];
    

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


@end
