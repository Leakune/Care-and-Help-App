//
//  AppDelegate.swift
//  Nesprecho
//

//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds) //taille window
         window.rootViewController = UINavigationController(rootViewController: homeViewController())
         window.makeKeyAndVisible()
         self.window = window
        
        return true
    }
}

