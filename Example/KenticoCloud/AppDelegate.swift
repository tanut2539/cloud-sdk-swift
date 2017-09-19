//
//  AppDelegate.swift
//  KenticoCloud
//
//  Created by martinmakarsky@gmail.com on 08/16/2017.
//  Copyright (c) 2017 martinmakarsky@gmail.com. All rights reserved.
//

import UIKit
import FAPanels
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
        
        configureNavigationBarAppearance()
        
        //  Load the Controllers
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let menu: MenuViewController = mainStoryboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        
        let center: CafesViewController = mainStoryboard.instantiateViewController(withIdentifier: "CafesViewController") as! CafesViewController
        let centerNavigationViewController = UINavigationController(rootViewController: center)
        
        //  Set the Panel controllers
        let rootController: FAPanelController = window?.rootViewController as! FAPanelController
        _ = rootController.center(centerNavigationViewController).left(menu)
        
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
    
    private func configureNavigationBarAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 178.0/255, green: 65.0/255, blue: 67.0/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
    }

    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
        
        // Persist it in your backend in case it's new
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
        
        if (contentType == "cafe") && (itemName != "unknown") {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let notificationCafeViewController = mainStoryboard.instantiateViewController(withIdentifier: "NotificationCafeViewController") as! NotificationCafeViewController
            notificationCafeViewController.cafeName = itemName
            self.window?.rootViewController?.present(notificationCafeViewController, animated: true, completion: nil)
        }
    }

}

