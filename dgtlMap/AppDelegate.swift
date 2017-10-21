//
//  AppDelegate.swift
//  dgtlMap
//
//  Created by Alyson Vivattanapa on 10/5/17.
//  Copyright © 2017 Alyson Vivattanapa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Override point for customization after application launch.

        FirebaseApp.configure()
        
        if UserDefaults.standard.value(forKey: "ID") == nil {
            Auth.auth().signInAnonymously() { (user, error) in
                if let id = user?.uid {
                    UserDefaults.standard.set(id, forKey: "ID")
                }
            }
        }
        
        let tabBarController = UITabBarController()
        let tabVC1 = MapViewController()
            
        let tabVC2 = LineupViewController(nibName: "LineupViewController", bundle: nil)
        
        tabVC1.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "mapTabIcon"), tag: 1)
        
        tabVC2.tabBarItem = UITabBarItem(title: "Status", image: UIImage(named: "lineupTabIcon"), tag: 2)
        
        let controllers = [tabVC1, tabVC2]
        tabBarController.viewControllers = controllers
        
        let navigationController = UINavigationController(rootViewController: tabBarController)

         self.window?.rootViewController = navigationController
        
        
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
    
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

