//
//  AppDelegate.swift
//  AT_Message
//
//  Created by 张西阖 on 06/11/2017.
//  Copyright © 2017 Aleph Tdu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let screen: CGRect = UIScreen.main.bounds
        window = UIWindow(frame: screen)
        window?.backgroundColor = UIColor.white
        let nav1 = UINavigationController.init(rootViewController: ChatListViewController())
        nav1.tabBarItem.title = "Chat"
        let nav2 = UINavigationController.init(rootViewController: ContactsViewController())
        nav2.tabBarItem.title = "Contacts"
        let nav3 = UINavigationController.init(rootViewController: FocusViewController())
        nav3.tabBarItem.title = "Focus"
        let nav4 = UINavigationController.init(rootViewController: SettingsViewController())
        nav4.tabBarItem.title = "Settings"
        
        let tabBar = UITabBarController()
        tabBar.selectedIndex = 0
        tabBar.viewControllers = [nav1, nav2, nav3, nav4]
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

