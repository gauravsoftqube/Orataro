//
//  AppDelegate.m
//  orataro
//
//  Created by harikrishna patel on 25/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "Global.h"
#import "REFrostedViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#define APPDELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]

@interface AppDelegate ()
{
    UIUserNotificationSettings *setting;
   // NSThread *th;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [Fabric with:@[[Crashlytics class]]];
    
   
    [DBOperation checkCreateDB];
    REFrostedViewController *rf = [[REFrostedViewController alloc]init];
    
    rf.panGestureEnabled = NO;
    
    
    _commonvar = 0;
    _checkhomeLang = 0;
    _scoolgroup = 0;
    _checkListelection = 0;
    _c2 = 0;
    _checkview = 0;

    
    UIDevice *device = [UIDevice currentDevice];
    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    NSLog(@"device=%@",currentDeviceId);
    
    //D736B155-DB5D-43F0-8DF8-B2362476B774
    
    [[NSUserDefaults standardUserDefaults]setValue:@"8BC8323E-0F34-460B-83EA-77043737F29C" forKey:@"currentDeviceId"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
  //
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        UIRemoteNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }

    // Override point for customization after application launch.
    return YES;
}

#pragma mark check rechability

+(BOOL)CheckInternetRechability
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return YES;
    }
    else
    {
        NSLog(@"There IS internet connection");
        return NO;
    }
    
    return NO;
}

#pragma mark - push notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token11 = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token11 = [token11 stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"device token is >>>>>>>>%@ Devicetoken=%@", token11,deviceToken);
    //[[NSUserDefaults standardUserDefaults]setObject:@"8d103a40eb95a3b95335ee64d2a5bf7a958fdffd3d029d6d3c0cc3dc6eca8298" forKey:@"DeviceToken"];
    [[NSUserDefaults standardUserDefaults]setObject:token11 forKey:@"DeviceToken"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);
}

//- (void)application:(UIApplication* )app didRegisterForRemoteNotificationsWithDeviceToken:(NSData* )deviceToken
//{
//    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
//    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
//    //_strToken = token;
//    
//    NSLog(@" content---%@", token);
//    [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"DeviceToken"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//    
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
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


- (void)applicationWillTerminate:(UIApplication *)application
{
//    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",cnt] forKey:@"RememberMe"];
//    
//    [[NSUserDefaults standardUserDefaults]setObject:_aPhonenumberTextField.text forKey:@"PhoneNumber"];
//    [[NSUserDefaults standardUserDefaults]setObject:_aPasswordTextField.text forKey:@"Password"];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"RememberMe"] isEqualToString:@"1"])
    {
        
    }
    else
    {
        
    }

    
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    NSLog(@"info %@", userInfo);
}

- (void)application:(UIApplication* )application didReceiveRemoteNotification:(NSDictionary * )userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    if(application.applicationState == UIApplicationStateInactive) {
        
        NSLog(@"Inactive");
        
        //Show the view with the content of the push
        
        completionHandler(UIBackgroundFetchResultNewData);
        
    } else if (application.applicationState == UIApplicationStateBackground) {
        
        NSLog(@"Background");
        
        NSString *info = [[userInfo valueForKey:@"aps"]valueForKey:@"alert"];
        
        completionHandler(UIBackgroundFetchResultNewData);
        
    } else {
        
        NSLog(@"Active");
        
        //Show an in-app banner
        
        completionHandler(UIBackgroundFetchResultNewData);
        
    }
}


@end
