//
//  CarplayViewController.swift
//  CarplayNavigationTesting
//
//  Created by Sander van Tulden on 02/07/2018.
//  Copyright © 2018 Sander van Tulden. All rights reserved.
//

import Foundation
import CarPlay

class CarplayViewController: UIViewController, CPInterfaceControllerDelegate {
    var mainView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.interfaceController?.delegate = self
        }
        
        if mainView == nil {
            mainView = Bundle.main.loadNibNamed("CarplayView", owner: self, options: nil)?.first as? UIView
            mainView?.frame = view.frame
            if let mainViewUnwrapped = mainView {self.view.addSubview(mainViewUnwrapped)}
        }
    }
}
