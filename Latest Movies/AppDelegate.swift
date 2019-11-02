//
//  AppDelegate.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let flow = AppFlowController(dependency: DependencyFactory())
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = flow
        window?.makeKeyAndVisible()
        
        return true
    }

}
