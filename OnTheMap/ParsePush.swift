//
//  ParsePush.swift
//  OnTheMap
//
//  Created by Edward Stamps on 5/11/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//


import Foundation
import UIKit


class ParsePush: NSObject {
    
    /* Shared session */
    var session: NSURLSession
    var appDelegate: AppDelegate!
    
    //    /* Configuration object */
    //    var config = TMDBConfig()
    
    /* Authentication state */
    //    var loginID : String? = nil
    //    var passwordID : String? = nil
    
    override init() {
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        session = NSURLSession.sharedSession()
        super.init()
        }
    
    func authenticateWithViewController(hostViewController: UIViewController, completionHandler: (success: Bool) -> Void) {
        self.pushParseInfo() { (success) in
            completionHandler(success:success)
        }
    }
    
    
    func pushParseInfo(completionHandler: (success: Bool) -> Void) {
        let locationIntel = self.appDelegate.locationInfo!
        println(locationIntel.coordinate.latitude)
        
        let latitudeIntel = locationIntel.coordinate.latitude as Double
        let longitudeIntel = locationIntel.coordinate.longitude as Double
        
        let sessionID = "{\"uniqueKey\": \"" + (self.appDelegate.sessionID! as! String) + "\", \"firstName\": \""
        let mydataUser = self.appDelegate.firstNameID! + "\", \"lastName\": \"" + self.appDelegate.lastNameID! + "\",\"mapString\": \""
        let mydataUser2 = self.appDelegate.cityInfo! + "\", \"mediaURL\": \"" + self.appDelegate.linkInfo! + "\","
        let mydataUser3 = "\"latitude\": " + "\(latitudeIntel)" + ", \"longitude\": " + "\(longitudeIntel)" + "}"
        let mydataUser4 = sessionID + mydataUser + mydataUser2 + mydataUser3
        let money = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}"
        
        //  println(mydataUser4)
        //    println(money)
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        request.HTTPMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = mydataUser4.dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            //    println(NSString(data: data, encoding: NSUTF8StringEncoding))
            completionHandler(success: true)
            
            
            
        }
        
        task.resume()
    }
    
    
    
    
    
    class func sharedInstance() -> ParsePush {
        
        struct Singleton {
            static var sharedInstance = ParsePush()
        }
        return Singleton.sharedInstance
    }
    
}
