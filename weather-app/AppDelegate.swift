//
//  AppDelegate.swift
//  finalProject
//
//  Created by Ksenia Zhizhimontova on 11/24/17.
//  Copyright © 2017 ksenia. All rights reserved.
//

import UIKit

extension UINavigationController {
    override open func viewDidLoad() {
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationBar.barTintColor = .locationBlue
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = false
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {
    
    let tabBarController = UITabBarController()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        // Set up view controllers
        let locationVC = UINavigationController(rootViewController: LocationViewController())
        let forecastVC = UINavigationController(rootViewController: ForecastViewController())
        
        let locationIcon = UITabBarItem(title: "Location", image: #imageLiteral(resourceName: "cloud"), selectedImage: #imageLiteral(resourceName: "cloud"))
        let forecastIcon = UITabBarItem(title: "Forecast", image: #imageLiteral(resourceName: "snow-flake"), selectedImage: #imageLiteral(resourceName: "snow-flake"))
        locationVC.tabBarItem = locationIcon
        forecastVC.tabBarItem = forecastIcon
        
        // Set up tab controller
        tabBarController.viewControllers = [locationVC, forecastVC]
        tabBarController.tabBar.clipsToBounds = true
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.layer.borderWidth = 0.5
        tabBarController.tabBar.layer.borderColor = UIColor.lightGray.cgColor
        tabBarController.delegate = self
        
        
        // Set up window
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.makeKeyAndVisible()
        window?.rootViewController = tabBarController
        
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

