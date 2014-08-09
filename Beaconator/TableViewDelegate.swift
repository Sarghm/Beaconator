//
//  TableViewDelegate.swift
//  Beaconator
//
//  Created by Sam Piggott on 07/08/2014.
//  Copyright (c) 2014 Sam Piggott. All rights reserved.
//

import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // TODO: Move to a more concise data source
    // Data source for debugging purposes will be a simple array of dictionaries
    
    let uuidArray = [["uuid":"dank", "name":"Name of ID"], ["uuid":"dank-2", "name":"Another iBeacon"]]
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return uuidArray.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        return cell
    }
    
    
}
