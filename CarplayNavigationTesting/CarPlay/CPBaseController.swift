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
class CPBaseController: NSObject, CPInterfaceControllerDelegate, CPMapTemplateDelegate {
    
    static let shared = CPBaseController()
    
    private var carplayInterfaceController: CPInterfaceController?
    private var carWindow: UIWindow?
    
    public var interfaceController: CPInterfaceController?
    public var mapTemplate: CPMapTemplate?
    
    override init() {
        super.init()
    }
    
    func interfaceController(_ interfaceController: CPInterfaceController, didConnectWith window: CPWindow) {
        print("Connected to CarPlay window.")
        interfaceController.delegate = self
        carplayInterfaceController = interfaceController
        window.rootViewController = MapViewController()
//        mapViewController.cpWindow = window
//        window.rootViewController = mapViewController

        carWindow = window

        /// - Tag: did_connect
        let mapTemplate = createTemplate()

        mapTemplate.mapDelegate = self

//        installBarButtons()

//        interfaceController.setRootTemplate(mapTemplate, animated: true)
    }
    
    func interfaceController(_ interfaceController: CPInterfaceController, didDisconnectWith window: CPWindow) {
        print("Disconnected from CarPlay window.")
        carplayInterfaceController = nil
        carWindow?.isHidden = true
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
