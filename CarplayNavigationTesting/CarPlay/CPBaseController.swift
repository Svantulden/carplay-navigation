//
//  CPBaseController.swift
//  CarplayNav
//
//  Created by Ryan Brispat on 22/09/2020.
//  Copyright © 2020 Sander van Tulden. All rights reserved.
//

import Foundation
import CarPlay
import MapKit

@available(iOS 13.4, *)
class CPBaseController {
    
    static let shared = CPBaseController()
    
    public var interfaceController: CPInterfaceController?
    public var carWindow: CPWindow?
    public var mapTemplate: CPMapTemplate?
    
    init() {
        
    }
    
    func ConnectedToCP(_ application: UIApplication, didConnectCarInterfaceController interfaceController: CPInterfaceController, to window: CPWindow){
        print("[CARPLAY] CONNECTED TO CARPLAY!")
        
        // Keep references to the CPInterfaceController (handles your templates) and the CPMapContentWindow (to draw/load your own ViewController's with a navigation map onto)
        self.interfaceController = interfaceController
        self.carWindow = window
        
        print("[CARPLAY] CREATING CPMapTemplate...")
        
        // Create a map template and set it as the root on the interfacecontroller (you may push/pop templates like a UINavigationController) Also assign delegate for the callbacks
        let mapTemplate = createTemplate()
//        mapTemplate.mapDelegate = self
        
        self.mapTemplate = mapTemplate
        
        print("[CARPLAY] SETTING ROOT OBJECT OF INTERFACECONTROLLER TO MAP TEMPLATE...")
        interfaceController.setRootTemplate(mapTemplate, animated: true)
        
//        print("[CARPLAY] SETTING CustomNavigationViewController as root VC...")
//        window.rootViewController = CustomNavigationViewController()
        
        // Note: Obviously the AppDelegate is a bad place to handle everything and save all your references. This is done for example, don't put everything in the same class 🙃
    }
    
    private func createTemplate() -> CPMapTemplate {
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
}
