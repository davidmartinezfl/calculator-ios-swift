//
//  AppDelegate.swift
//  calculator-ios-swift
//
//  Created by David Martinez on 25/02/20.
//  Copyright © 2020 David Martinez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Setup
        setupView()
        
        return true
    }
    
    // MARK: - Private methods
    
    public func setupView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

}

