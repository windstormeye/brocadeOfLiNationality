//
//  AppDelegate.swift
//  WWDC19
//
//  Created by PJHubs on 2019/3/16.
//  Copyright © 2019 PJHubs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = PJHomeViewController()
        vc.brocadeType = .normal
        vc.brocadeBackgroundColor = .bgColor()
        vc.sizeType = .rectangle
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}

