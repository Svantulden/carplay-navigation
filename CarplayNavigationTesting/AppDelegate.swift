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

    // MARK: - CarPlay Reference variables
    var carWindow: CPMapContentWindow?
    var interfaceController: CPInterfaceController?
    var mapTemplate: CPMapTemplate?
    
    // MARK: - Needed to show initial storyboard
    var window: UIWindow?

    // MARK: - CPApplicationDelegate methods
    func application(_ application: UIApplication, didConnectCarInterfaceController interfaceController: CPInterfaceController, to window: CPMapContentWindow) {
        print("[CARPLAY] CONNECTED TO CARPLAY!")
        
        // Keep references to the CPInterfaceController (handles your templates) and the CPMapContentWindow (to draw/load your own ViewController's with a navigation map onto)
        self.interfaceController = interfaceController
        self.carWindow = window
        
        print("[CARPLAY] CREATING CPMapTemplate...")
        
        // Create a map template and set it as the root on the interfacecontroller (you may push/pop templates like a UINavigationController) Also assign delegate for the callbacks
        let mapTemplate = createTemplate()
        mapTemplate.mapDelegate = self
        
        self.mapTemplate = mapTemplate
        
        print("[CARPLAY] SETTING ROOT OBJECT OF INTERFACECONTROLLER TO MAP TEMPLATE...")
        interfaceController.setRootTemplate(mapTemplate, animated: true)
        
        print("[CARPLAY] SETTING CustomNavigationViewController as root VC...")
        window.rootViewController = CustomNavigationViewController()
        
        // Note: Obviously the AppDelegate is a bad place to handle everything and save all your references. This is done for example, don't put everything in the same class 🙃
    }
    
    func application(_ application: UIApplication, didDisconnectCarInterfaceController interfaceController: CPInterfaceController, from window: CPMapContentWindow) {
        print("[CARPLAY] DISCONNECTED FROM CARPLAY!")
    }
    
    func application(_ application: UIApplication, didSelect navigationAlert: CPNavigationAlert) {
        // TODO: Implementation
    }
    
    func application(_ application: UIApplication, didSelect maneuver: CPManeuver) {
        // TODO: Implementation
    }
    
    // MARK: - CPMapTemplate creation
    func createTemplate() -> CPMapTemplate {
        // Create the default CPMapTemplate objcet (you may subclass this at your leasure)
        let mapTemplate = CPMapTemplate()
        
        // Create the different CPBarButtons
        let searchBarButton = createBarButton(.search)
        mapTemplate.leadingNavigationBarButtons = [searchBarButton]
        
        let panningBarButton = createBarButton(.panning)
        mapTemplate.trailingNavigationBarButtons = [panningBarButton]
        
        // Always show the NavigationBar
        mapTemplate.automaticallyHidesNavigationBar = false
        
        return mapTemplate
    }
    
    // MARK: - CPMapTemplate delegate method
    func mapTemplateWillDismissPanningInterface(_ mapTemplate: CPMapTemplate) {
        mapTemplate.trailingNavigationBarButtons = [createBarButton(.panning)]
    }
    
    // MARK: - CPBarButton creation
    enum BarButtonType: String {
        case search = "Search"
        case panning = "Pan map"
        case dismiss = "Dismiss"
    }
    
    private func createBarButton(_ type: BarButtonType) -> CPBarButton {
        let barButton = CPBarButton(type: .text) { (button) in
            print("[CARPLAY] SEARCH MAP TEMPLATE \(button.title ?? "-") TAPPED")
            
            switch(type) {
            case .dismiss:
                // Dismiss the map panning interface
                self.mapTemplate?.dismissPanningInterface(animated: true)
            case .panning:
                // Enable the map panning interface and set the dismiss button
                self.mapTemplate?.showPanningInterface(animated: true)
                self.mapTemplate?.trailingNavigationBarButtons = [self.createBarButton(.dismiss)]
            default:
                break
            }
        }
        
        // Set title based on type
        barButton.title = type.rawValue
        
        return barButton
    }
    
    // MARK: - Unimplemented UIApplicationDelegate delegate methods
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

