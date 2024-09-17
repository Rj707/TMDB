//
//  AppDelegate.swift
//  Practice
//
//  Created by iApple Basement on 09/05/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var mainCoordinater: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        mainCoordinater = MainCoordinator(navigationController: navigationController)
        mainCoordinater?.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }


}

