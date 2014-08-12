//
//  DealScreen.swift
//  Beaconator
//
//  Created by Sam Piggott on 11/08/2014.
//  Copyright (c) 2014 Sam Piggott. All rights reserved.
//

import UIKit

class DealScreen: UIViewController {
    
    var detectedBeacon:CLBeacon?
    var dealTitleLabel:UILabel!
    var dealDescriptionLabel:UILabel!
    var redeemedLabel:UILabel!
    
    func setupDealWithBeacon(beacon:CLBeacon) {
        
        detectedBeacon = beacon
        performDealQuery()
        
    }
 
    func performDealQuery() {
        // Load/detect the information in for the deal by performing a Parse query
        
        var dealQuery = PFQuery(className: "deal")
        dealQuery.whereKey("deal_major", equalTo: detectedBeacon?.major)
        
        
        dealQuery.getFirstObjectInBackgroundWithBlock({
            (deal:PFObject!, error:NSError!) -> Void in
            if !error {
                // Parse query succeeded - update screen with deal information
                print("Success!")
                self.dealTitleLabel.text = deal.valueForKey("deal_title") as String
                self.dealDescriptionLabel.text = deal.valueForKey("deal_description") as String
            }
            else {
                // Parse query failed - show alert and then roll back to detecting screen
                print("Query failed.")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup screen
        
        view.backgroundColor = UIColor.whiteColor()
        
        dealTitleLabel = UILabel(frame: CGRectMake(10, 30, 300, 50))
        dealDescriptionLabel = UILabel(frame: CGRectMake(10, 90, 300, 50))
        redeemedLabel = UILabel(frame: CGRectMake(10, 140, 300, 50))
        
        view.addSubview(dealTitleLabel)
        view.addSubview(dealDescriptionLabel)
        view.addSubview(redeemedLabel)
        
    }

}
