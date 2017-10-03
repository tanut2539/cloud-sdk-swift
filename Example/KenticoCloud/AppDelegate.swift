//
//  AppDelegate.swift
//  KenticoCloud
//
//  Created by martinmakarsky@gmail.com on 08/16/2017.
//  Copyright (c) 2017 martinmakarsky@gmail.com. All rights reserved.
//

import UIKit
import KenticoCloud
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Register for notifications
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        application.registerForRemoteNotifications()
        
        // Appearance customization
        UINavigationBar.appearance().isHidden = true
        UITableView.appearance().backgroundColor = AppConstants.globalBackgroundColor
        UITableViewCell.appearance().backgroundColor = AppConstants.globalBackgroundColor
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        let trackingClient = TrackingClient.init(projectId: AppConstants.trackingProjectId, enableDebugLogging: true)
        trackingClient.startSession()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})

        print("APNs device token: \(deviceTokenString)")
        
        // Persist it in your backend in case it's new
        let uid = TrackingSessionHelper.getUid()
        let notificationService = NotificationService.init()
        notificationService.registerForNotifications(deviceToken: deviceTokenString, uid: uid)
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        let itemName = (data["itemName"] ?? "unknown") as! String
        let contentType = (data["contentType"] ?? "unknown") as! String
        
        if (contentType == "coffee") && (itemName != "unknown") {
            let client = DeliveryClient.init(projectId: AppConstants.projectId)
            client.getItem(modelType: Coffee.self, itemName: itemName) { (isSuccess, itemResponse, error) in
                if isSuccess {
                    if let coffee = itemResponse?.item {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let coffeeNotificationViewController = mainStoryboard.instantiateViewController(withIdentifier: "CoffeeNotificationViewController") as! CoffeeNotificationViewController
                        coffeeNotificationViewController.coffee = coffee
                        self.window?.rootViewController?.present(coffeeNotificationViewController, animated: true, completion: nil)
                    }
                } else {
                    if let error = error {
                        print(error)
                    }
                }
            }
        }
    }

}

