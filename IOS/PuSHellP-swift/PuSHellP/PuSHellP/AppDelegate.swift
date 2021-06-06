//
//  AppDelegate.swift
//  Nesprecho
//
//  Created by Benoit Briatte on 03/02/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds) //taille window
         window.rootViewController = homeViewController()
         window.makeKeyAndVisible()
         self.window = window
        
        return true
    }
}

