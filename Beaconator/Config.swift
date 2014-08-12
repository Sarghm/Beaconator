//
//  Config.swift
//  Beaconator
//
//  Created by Sam Piggott on 12/08/2014.
//  Copyright (c) 2014 Sam Piggott. All rights reserved.
//

import Foundation

class Config:NSObject {

class func getParseKey(type:String) -> String? {
    switch type {
        case "accessKey":
            return "N0BF9tX20yeOmDvjcd5RnOLAuqf6JAwvZqTS2zmu"
        case "clientKey":
            return "fcQaoJaZzj3Pw8kzooXeELOrNwQAvjGYoDMhpiRd"
    default:
        return nil
    }
    
}

}