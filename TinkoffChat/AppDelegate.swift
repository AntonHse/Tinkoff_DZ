//
//  AppDelegate.swift
//  DZ_1
//
//  Created by Антон Шуплецов on 09/02/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var flag : Bool = false
    var window: UIWindow?
    
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if flag{print("Application moved from Not running to Foreground(Inactive): \(#function)")}

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       if flag{print("Application moved from Foreground(Active) to Foreground(Inactive): \(#function)")}
       // print("applicationWillResignActive method was called")
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        if flag{print("Application moved from Foreground(Inactive) to Background: \(#function)")}
       // print("applicationDidEnterBackground method was called")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        if flag{print("Application moved from Background to Foreground(Inactive): \(#function)")}
       // print("applicationWillEnterForeground method was called")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if flag{print("Application moved from Foreground(Inactive) to Foreground(Active): \(#function)")}
        //print("applicationDidBecomeActive method was called")
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        if flag{print("Application is closed: moved from Suspended to Not running: \(#function)")}
        //print("applicationWillTerminate method was called")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    

}

    
