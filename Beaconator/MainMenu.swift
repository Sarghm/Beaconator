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
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Setup view
        
        view.backgroundColor = UIColor.whiteColor()
        
        // Setup the home view
        
        statusLabel = UILabel()
        
        // MARK: Auto-Layout
        
        // Deactivate conflicting view constraints to eliminate later issues
        
        statusLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Add views to stack
        
        self.view.addSubview(statusLabel)
        
        addConstraints()
        
    }
    
    // Add constraints
    
    func addConstraints() {
        
        self.view.addConstraint(NSLayoutConstraint(item: statusLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.LessThanOrEqual, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 40))
        self.view.addConstraint(NSLayoutConstraint(item: statusLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 40))
        self.view.addConstraint(NSLayoutConstraint(item: statusLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
    }
    

}

