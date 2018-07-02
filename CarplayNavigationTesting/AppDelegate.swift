//
//  AppDelegate.swift
//  CarplayNavigationTesting
//
//  Created by Sander van Tulden on 02/07/2018.
//  Copyright © 2018 Sander van Tulden. All rights reserved.
//

import UIKit
import CarPlay

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CPApplicationDelegate, CPMapTemplateDelegate {

    var carWindow: UIWindow?
    var interfaceController: CPInterfaceController?

    func application(_ application: UIApplication, didConnectCarInterfaceController interfaceController: CPInterfaceController, to window: CPMapContentWindow) {
        print("[CARPLAY] CONNECTED TO CARPLAY!")
        
        self.interfaceController = interfaceController
        self.carWindow = window
        
        print("[CARPLAY] SETTING CarplayViewController as root VC...")
        window.rootViewController = CarplayViewController()
        
        print("[CARPLAY] CREATING CPMapTemplate...")
        let mapTemplate: CPMapTemplate = createTemplate()
        
        print("[CARPLAY] SETTING ROOT OBJECT OF INTERFACECONTROLLER TO MAP TEMPLATE...")
        interfaceController.setRootTemplate(mapTemplate, animated: true)
    }
    
    func application(_ application: UIApplication, didDisconnectCarInterfaceController interfaceController: CPInterfaceController, from window: CPMapContentWindow) {
        print("[CARPLAY] DISCONNECTED FROM CARPLAY!")
    }
    
    func application(_ application: UIApplication, didSelect navigationAlert: CPNavigationAlert) {
        
    }
    
    func application(_ application: UIApplication, didSelect maneuver: CPManeuver) {
        
    }
    
    func createTemplate() -> CPMapTemplate {
        let mapTemplate = CPMapTemplate()
        mapTemplate.mapDelegate = self
        
        let reportButton = CPBarButton(type: .text) { (button) in
            
        }
        
        reportButton.title = "Melden"
        
        mapTemplate.trailingNavigationBarButtons = [reportButton]
        
        return mapTemplate
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

