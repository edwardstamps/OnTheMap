//
//  UdacityLogin.swift
//  OnTheMap
//
//  Created by Edward Stamps on 5/6/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//

import Foundation
import UIKit


class UdacityLogin: NSObject {
    
    /* Shared session */
    var session: NSURLSession
    var appDelegate: AppDelegate!

    
    override init() {
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        session = NSURLSession.sharedSession()
        super.init()
    }
//
    // MARK: - GET
    
    var sessionID: AnyObject? = nil
    
    
    func authenticateWithViewController(hostViewController: UIViewController, completionHandler: (success: Bool) -> Void) {
        self.setUserID() { (success) in
            completionHandler(success: success)
        }
    }
    
    
    func setUserID(completionHandler: (success: Bool) -> Void){
        
        let mydataUser = "{\"udacity\": {\"username\": \"" + self.appDelegate.loginID! + "\", \"password\": \"" + self.appDelegate.passwordID! + "\"}}"
        // println(mydataUser)
        
        //3. configure request. hardcoded URL string
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = mydataUser.dataUsingEncoding(NSUTF8StringEncoding)
        session = NSURLSession.sharedSession()
        
        // println(request.HTTPBody)
        
        //4. make request
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
          
                return
            }
            
            
            
            
            
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
            
            var parsingError: NSError? = nil
            let parsedResult = NSJSONSerialization.JSONObjectWithData(newData, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
            
            //  println(parsedResult)
            
            if let account: AnyObject = parsedResult["account"] {
                if var sessionIDnow: AnyObject? = account["key"]{
                    // sessionIDnow = sessionIDnow[2,4]
                    self.appDelegate.sessionID = sessionIDnow
                    self.getUserID(completionHandler)
                    
                    
                    
                    println(self.appDelegate.sessionID)
                    
                    
                }
            }
            else {
                self.appDelegate.errorString = "Login Failed"
                println("login fail")
                completionHandler(success: false)
                return
            }
        }
        task.resume()
        
    }
    
    
    func getUserID(completionHandler: (success: Bool) -> Void) {
        
        let userID: AnyObject! = self.appDelegate.sessionID
        
        //println(userID)
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/users/" + "\(userID!)")!)
        //   println(request)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error...
               
                return
            }
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
            println(NSString(data: newData, encoding: NSUTF8StringEncoding))
            
            var parsingError: NSError? = nil
            let parsedResult = NSJSONSerialization.JSONObjectWithData(newData, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
            //  println(parsedResult)
            
            if let account: AnyObject = parsedResult["user"] {
                var userIDnow = account["first_name"] as! String
                var userIDnow2 = account["last_name"] as! String
                var userIDnow3 = userIDnow + " " + userIDnow2
                self.appDelegate.firstNameID = userIDnow
                self.appDelegate.lastNameID = userIDnow2
                self.appDelegate.nameID = userIDnow3
                println(userIDnow3)
               // self.completeLogin()
                completionHandler(success: true)
            }
            else {
            self.appDelegate.errorString = "Error Reaching Network"
            println("error")
            completionHandler(success: false)
            }
            
        }
        task.resume()
        
    }
    
    class func sharedInstance() -> UdacityLogin {
        
        struct Singleton {
            static var sharedInstance = UdacityLogin()
        }
        return Singleton.sharedInstance
    }
    
    
    
}


