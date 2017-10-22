//
//  AppDelegate.swift
//  MyFbPhotos
//
//  Created by Mohamed BOUNAJMA on 10/21/17.
//  Copyright © 2017 Mohamed BOUNAJMA. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Configure the main window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        if let token = AccessToken.current, let permissions =  token.grantedPermissions, permissions.contains("user_photos") {
            setAlbumPage()
        } else {
            setWelcomePage()
        }
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return SDKApplicationDelegate.shared.application(_:app, open: url, options: options)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    func setWelcomePage() {
        let welcome = WelcomePage(nibName: "WelcomePage", bundle: nil)
        self.navigationController = UINavigationController(rootViewController: welcome)
        self.navigationController!.setNavigationBarHidden(true, animated: false)
        UIView.transition(with: self.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.window!.rootViewController = self.navigationController
        }, completion: nil)
    }
    
    func setAlbumPage() {
        let albums = MyAlbums(nibName: "MyAlbums", bundle: nil)
        self.navigationController = UINavigationController(rootViewController: albums)
        self.navigationController!.setNavigationBarHidden(true, animated: false)
        UIView.transition(with: self.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.window!.rootViewController = self.navigationController
        }, completion: nil)
    }

}

