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
    
    var app = UIApplication.sharedApplication()
    let locationManager = CLLocationManager()
    var mainMenu:MainMenu!
    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "6B358BF5-8236-4523-BF02-0F8E2552BCC3"), identifier: "AppUUID")
    var currentStatus:String? {
        didSet {
            mainMenu?.statusLabel?.text = currentStatus
        }
    }

    override init() {
        super.init()
        
        locationManager.delegate = self
        
        // Beacon Region setup
        
        beaconRegion.notifyOnEntry = true
        beaconRegion.notifyOnExit = true
        
        if (locationManager.respondsToSelector("requestAlwaysAuthorization")) {
            locationManager.requestAlwaysAuthorization()
        }
        
    }
    
    func rangeBeacon(region: CLBeaconRegion) {
        
        print("Began ranging")
        currentStatus = "Beacon ranging..."
        locationManager.startRangingBeaconsInRegion(region)
        
    }
    
    func monitorBeacon(region: CLRegion) {
        
        print("Began monitoring")
        currentStatus = "Began monitoring..."
        locationManager.startMonitoringForRegion(region)
        
    }
    
    func fireLocalNotification(beacon:CLBeacon!) {
        // Found a region - push the notification and the voucher screen if the app is open
        
        var notification = UILocalNotification()
        notification.alertAction = "Open Beaconator"
        notification.alertBody = "You've discovered a beacon!"
        currentStatus = "Discovered beacon!"
        notification.fireDate = nil
        
        // Store the details of the deal in the user info as key/value pairs so that they can be fetched by the app at a later date if the user decides to

        if (notification.userInfo != nil) {
            notification.userInfo["beacon"] = beacon
            print("User info exists - saved in existing dictionary.")
        }
            
        else {
            var notificationUserInfo:Dictionary<String, AnyObject>!
            notificationUserInfo["beacon"] = beacon
            print("User info does not exist - created a new dictionary!")
        }
        
        // Get active app instance and schedule the notification to trigger immediately
        app.scheduleLocalNotification(notification)
    }
    
    // MARK: CLLocation Delegate
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {

        switch status {
        case CLAuthorizationStatus.Authorized:
            
            locationManager.startUpdatingLocation()
            rangeBeacon(beaconRegion)
            monitorBeacon(beaconRegion)
            currentStatus = "Began monitoring..."
            print("Begin monitoring...")
            
            // Code for successful authorization
            
        case CLAuthorizationStatus.Denied:
            
            currentStatus = "Authorization status denied!"
            print("Denied access! Alert user that they need to allow BT access for the app to function.")
            
            // Code for failed authorization - alert the user
            
        default:
            
            print("Default result")
            // By default, assume failure/on-the-fence logic
            locationManager.startUpdatingLocation()
            rangeBeacon(beaconRegion)
            monitorBeacon(beaconRegion)
            
            currentStatus = "Began monitoring..."
            print("Began monitoring...")
        }
        
        // Hacky solution - Force beginning of monitoring for region, allows us to avoid moving out and in range
        // self.locationManager(self.locationManager, didStartMonitoringForRegion: beaconRegion)
        
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [CLBeacon]!, inRegion region: CLBeaconRegion!) {
        print("Ranging beacons...")
        
        if beacons.count > 0 {
            
            var discoveredBeacon:CLBeacon = beacons[0]
            // Found a beacon - stop ranging!
            manager.stopRangingBeaconsInRegion(region)
            let alert = UIAlertView(title: "Beacon found!", message: "Found beacon with UUID: \(discoveredBeacon.proximityUUID)", delegate: nil, cancelButtonTitle: "Awesome!")
            alert.show()
            
            // Present the view if the view is active. Otherwise, we're going to rely on the AppDelegate method to do this for us when it opens, responding to a deal
            
            if (app.applicationState == UIApplicationState.Active) {
                let dealScreen = DealScreen(nibName: nil, bundle: nil)
                dealScreen.setupDealWithBeacon(discoveredBeacon)
                mainMenu.presentViewController(dealScreen, animated: true, completion: nil)
            }
                
            else {
                fireLocalNotification(discoveredBeacon)
            }
            
        }
        
    }
 
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        print("Monitoring failed!")
        currentStatus = "Monitoring failed - check your bluetooth!"
    }
    
    func locationManager(manager: CLLocationManager!, rangingBeaconsDidFailForRegion region: CLBeaconRegion!, withError error: NSError!) {
        print("Ranging failed.")
        currentStatus = "Ranging beacon failed!"
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("Failed with error: \(error.description)")
        currentStatus = "Location manager failed with error: \(error.description)"
    }
    
    // MARK: Monitoring Regions
    
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        print("Monitoring...")
        currentStatus = "Monitoring..."
        print("Request state for region: \(manager.requestStateForRegion(region))")
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        let alertView = UIAlertView(title: "Entered Region", message: "Entered. Current regions: \(manager.monitoredRegions)", delegate: nil, cancelButtonTitle: "Cool")
        alertView.show()
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        let alertView = UIAlertView(title: "Exited Region", message: "Exited. Current regions: \(manager.monitoredRegions)", delegate: nil, cancelButtonTitle: "Cool")
        alertView.show()
        // Exited region - close notification
    }
    
}
