//
//  MapInfo.swift
//  OnTheMap
//
//  Created by Edward Stamps on 4/20/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapPin : NSObject, MKAnnotation {
    let firstName: String
    let lastName : String
    let title: String
    let locationName: String
    let subtitle: String
    let coordinate: CLLocationCoordinate2D
    
    init(dictionary: [String : AnyObject]) {
       firstName = dictionary["firstName"] as! String
        lastName = dictionary["lastName"] as! String
       title = firstName + " " + lastName
        
        locationName = dictionary["mapString"] as! String
        subtitle = dictionary["mediaURL"] as! String
        
        coordinate = CLLocationCoordinate2D(latitude: dictionary["latitude"] as! Double, longitude: dictionary["longitude"] as! Double)
        
        super.init()
        
        
     
    }

    static func pinsFromResults(results: [[String : AnyObject]]) -> [MapPin] {
    // 1
    var pins = [MapPin]()
    
    /* Iterate through array of dictionaries; each Movie is a dictionary */
    for result in results {
        pins.append(MapPin(dictionary: result))
    }
    
    return pins
}
}
