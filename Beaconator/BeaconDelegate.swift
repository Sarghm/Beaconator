//
//  BeaconDelegate.swift
//  Beaconator
//
//  Created by Sam Piggott on 06/08/2014.
//  Copyright (c) 2014 Sam Piggott. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconDelegate: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "6B358BF5-8236-4523-BF02-0F8E2552BCC3"), identifier: "Identifier")
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        
        // Beacon Region setup
        
        beaconRegion.notifyOnEntry = true
        beaconRegion.notifyOnExit = true
        
        if (locationManager.respondsToSelector("requestAlwaysAuthorization")) {
            locationManager.requestAlwaysAuthorization()
        }
        
        switch CLLocationManager.authorizationStatus() {
        case CLAuthorizationStatus.Authorized:
            
            print("Authorized!")
            rangeBeacon(beaconRegion)
            monitorBeacon(beaconRegion)
            
            // Code for successful authorization
            
        case CLAuthorizationStatus.Denied:
            
            print("Denied!")
            // Code for failed authorization - alert the user
            
        default:
            
            print("Default result")
            
            // By default, assume failure/on-the-fence logic
            rangeBeacon(beaconRegion)
            monitorBeacon(beaconRegion)
        }
        
    }
    
    func rangeBeacon(region: CLBeaconRegion) {
        
        print("Began ranging for UUID")
        locationManager.startRangingBeaconsInRegion(region)
    }
    
    func monitorBeacon(region: CLRegion) {
        
        print("Began monitoring for UUID")
        locationManager.startMonitoringForRegion(region)
    }
    
    // MARK: CLLocation Delegate
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.Authorized:
            print("Now authorized!")
            
        default:
            print("Authorization failed.")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [CLBeacon]!, inRegion region: CLBeaconRegion!) {
        print("Ranging beacons...")
        
        if beacons.count > 0 {
            
            var discoveredBeacon:CLBeaconRegion = beacons[0]
            // Found a beacon - stop ranging!
            manager.stopRangingBeaconsInRegion(region)
            let alert = UIAlertView(title: "Beacon found!", message: "Found beacon with UUID: \(beacons[0])", delegate: nil, cancelButtonTitle: "Awesome!")
            alert.show()
            
        }
        
    }
 
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        print("Monitoring failed!")
    }
    
    func locationManager(manager: CLLocationManager!, rangingBeaconsDidFailForRegion region: CLBeaconRegion!, withError error: NSError!) {
        print("Ranging failed.")
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("Failed with error: \(error.description)")
    }
    
    // MARK: Monitoring Regions
    
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        print("Monitoring...")
        print("Current regions: \(manager.monitoredRegions)")
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        let alertView = UIAlertView(title: "Entered Region", message: "Entered. Current regions: \(manager.monitoredRegions)", delegate: nil, cancelButtonTitle: "Cool")
        alertView.show()
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        let alertView = UIAlertView(title: "Exited Region", message: "Exited. Current regions: \(manager.monitoredRegions)", delegate: nil, cancelButtonTitle: "Cool")
        alertView.show()
    }
    
}
