//
//  AppDelegate.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 02/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let current = UIApplication.shared.delegate as! AppDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        window = UIWindow(frame: UIScreen.main.bounds)
//           
//        let screen = ScreenOneController.init(nibName: "ScreenOneController", bundle: nil)
//        window?.rootViewController = screen
//        window?.makeKeyAndVisible()
        return true
    }


    
    /**
     This function set the view controller become a root of application
     **/
    func setRootViewController(viewController: UIViewController) {
        
        UIView.transition(with: window!, duration: 0.25, options: [.transitionCrossDissolve, .allowAnimatedContent], animations: {
            
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.window?.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
            
        }) { (finished) in
            
        }
    }


}

