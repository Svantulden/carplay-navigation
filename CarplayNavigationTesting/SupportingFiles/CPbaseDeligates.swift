//
//  CPbaseDeligates.swift
//  CarplayNav
//
//  Created by Ryan Brispat on 25/09/2020.
//  Copyright © 2020 Sander van Tulden. All rights reserved.
//

import UIKit
import CarPlay

class TemplateApplicationSceneDelegate: NSObject {
    // MARK: UISceneDelegate
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("Enterd TemplateApplicationSceneDelegate.")
        if scene is CPTemplateApplicationScene, session.configuration.name == "TemplateSceneConfiguration" {
            print("Template application scene will connect.")
        } else if scene is CPTemplateApplicationDashboardScene, session.configuration.name == "DashboardSceneConfiguration" {
            print("Template application dashboard scene will connect.")
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        if scene.session.configuration.name == "TemplateSceneConfiguration" {
            print("Template application scene did disconnect.")
        } else if scene.session.configuration.name == "DashboardSceneConfiguration" {
            print("Template application dashboard scene did disconnect.")
        }
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        if scene.session.configuration.name == "TemplateSceneConfiguration" {
            print("Template application scene did become active.")
        } else if scene.session.configuration.name == "DashboardSceneConfiguration" {
            print("Template application dashboard scene did become active.")
        }
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        if scene.session.configuration.name == "TemplateSceneConfiguration" {
            print("Template application scene will resign active.")
        } else if scene.session.configuration.name == "DashboardSceneConfiguration" {
            print("Template application dashboard scene will resign active.")
        }
    }
}

// MARK: CPTemplateApplicationSceneDelegate
extension TemplateApplicationSceneDelegate: CPTemplateApplicationSceneDelegate {
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                  didConnect interfaceController: CPInterfaceController, to window: CPWindow) {
        print("Connected to CarPlay.")
        CPBaseController.shared.interfaceController(interfaceController, didConnectWith: window)
    }
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                  didDisconnect interfaceController: CPInterfaceController, from window: CPWindow) {
        CPBaseController.shared.interfaceController(interfaceController, didDisconnectWith: window)
        print("Disconnected from CarPlay.")
    }
}

extension TemplateApplicationSceneDelegate: CPTemplateApplicationDashboardSceneDelegate {
    // MARK: CPTemplateApplicationDashboardSceneDelegate
    
    func templateApplicationDashboardScene(
        _ templateApplicationDashboardScene: CPTemplateApplicationDashboardScene,
        didConnect dashboardController: CPDashboardController,
        to window: UIWindow) {
        print("Connected to CarPlay dashboard.")
        CPBaseController.shared.dashboardController(dashboardController, didConnectWith: window)
    }
    
    func templateApplicationDashboardScene(
        _ templateApplicationDashboardScene: CPTemplateApplicationDashboardScene,
        didDisconnect dashboardController: CPDashboardController,
        from window: UIWindow) {
        CPBaseController.shared.dashboardController(dashboardController, didDisconnectWith: window)
        print("Disconnected from CarPlay dashboard.")
    }
    
}


extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
