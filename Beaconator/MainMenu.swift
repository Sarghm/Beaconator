//
//  ViewController.swift
//  Beaconator
//
//  Created by Sam Piggott on 05/08/2014.
//  Copyright (c) 2014 Sam Piggott. All rights reserved.
//

import UIKit
import CoreLocation

class MainMenu: UIViewController {
    
    var statusLabel:UILabel!
    
    // Init the beacon
    
    let beacon = BeaconDelegate()
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // Loaded successfully - connect view with the beacon delegate
        beacon.mainMenu = self
    }
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Setup view
        
        view.backgroundColor = UIColor.whiteColor()
        
        // Setup the home view
        
        statusLabel = UILabel(frame: CGRectMake(25, 25, self.view.bounds.width-50, self.view.bounds.height-50))
        
        // Add views to stack
        
        view.addSubview(statusLabel)
        
    }
    

}

