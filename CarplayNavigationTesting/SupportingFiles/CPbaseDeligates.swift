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
