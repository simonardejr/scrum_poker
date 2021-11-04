//
//  AppDelegate.swift
//  scrumpoker
//
//  Created by Simonarde Lima on 02/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let sprintrouter = SprintRouter()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = application.windows.first ?? UIWindow(frame: UIScreen.main.bounds)
        sprintrouter.present(on: window)
        self.window = window
        window.makeKeyAndVisible()
         
        return true
    }


}

