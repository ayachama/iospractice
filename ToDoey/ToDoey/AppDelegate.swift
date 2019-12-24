//
//  AppDelegate.swift
//  ToDoey
//
//  Created by Avinash Yachamaneni on 10/13/19.
//  Copyright © 2019 Avinash Yachamaneni. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    //Note: First method to load in the app. Even if app crashes this gets called.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("application")
        // Override point for customization after application launch.
        return true
    }
    
    //Note: Gets called when app is going from active to inactive state.
    //Ex: User gets a call when using the app, user initiates to quit the application.
    //Usage: Disable ongoing animation, timer, invalid graphic rendering call back.
    //Games / Video player should pause the app.
    func applicationWillResignActive(_ application: UIApplication) {
        print("applicationWillResignActive")
    }
    
    //Note: When app disappear off the screen and enters background.
    //Ex: Pressing home button.
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
    }
    
    //Note: When app's about to get terminated.
    //Ex: Kill the app.
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
    }
    
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

