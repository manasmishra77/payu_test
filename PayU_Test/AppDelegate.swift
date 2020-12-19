//
//  AppDelegate.swift
//  PayU_Test
//
//  Created by Manas1 Mishra on 19/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureRootVC()
        
        return true
    }
    
    func configureRootVC() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = MovieListViewController()
        let navvc = UINavigationController(rootViewController: vc)
        
        self.window?.rootViewController = navvc
        self.window?.makeKeyAndVisible()
    }



}

