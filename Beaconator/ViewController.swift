//
//  ViewController.swift
//  Beaconator
//
//  Created by Sam Piggott on 05/08/2014.
//  Copyright (c) 2014 Sam Piggott. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let beacon = BeaconDelegate()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.redColor()
        
        // First setup: CoreLocation Setup - Check to make sure it's available
        

    }
    

}

