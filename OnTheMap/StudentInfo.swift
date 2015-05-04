//
//  StudentInfo.swift
//  OnTheMap
//
//  Created by Edward Stamps on 4/16/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//

import Foundation
import UIKit

struct Student {
    
    var firstName = ""
    var lastName = ""
    var title = ""
    var lati = Int()
    var longi = Int()
    var city = ""
    var theUrl = ""
    
    init(dictionary: [String : AnyObject]) {
        firstName = dictionary["firstName"] as! String
        lastName = dictionary["lastName"] as! String
        firstName = dictionary["firstName"] as! String
        lastName = dictionary["lastName"] as! String
        title = firstName + " " + lastName
        lati = dictionary["latitude"] as! Int
        longi = dictionary["longitude"] as! Int
        city = dictionary["mapString"] as! String
        theUrl = dictionary["mediaURL"] as! String
        
    }
    
    static func studentsFromResults(results: [[String : AnyObject]]) -> [Student] {
        
        var students = [Student]()
        
        /* Iterate through array of dictionaries; each Movie is a dictionary */
        for result in results {
            students.append(Student(dictionary: result))
        }
        
        return students
    }
    

}
