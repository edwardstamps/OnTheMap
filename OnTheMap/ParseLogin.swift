//
//  ParseLogin.swift
//  OnTheMap
//
//  Created by Edward Stamps on 5/6/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//



import Foundation
import UIKit
    
    
class ParseLogin: NSObject {
        
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
        //
        // MARK: - GET
        
        var sessionID: AnyObject? = nil
        
        func authenticateWithViewController(hostViewController: UIViewController, completionHandler: (success: Bool) -> Void) {
            self.getParseInfo() { (success) in
                completionHandler(success:success)
            }
        }
        
        func getParseInfo(completionHandler: (success: Bool) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error...
                self.appDelegate.errorString = "Load Error. Please refresh"
                completionHandler(success: false)
                return
            }
            // let newData = (NSString(data: data, encoding: NSUTF8StringEncoding))
            var parsingError: NSError? = nil
            let parsedResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil ) as! [String : AnyObject]
            self.appDelegate.dataStuff = parsedResult
            println(self.appDelegate.dataStuff)
            // self.UserInfo()
            //self.tranList()
            completionHandler(success: true)
        }
        task.resume()
    }
        
        class func sharedInstance() -> ParseLogin {
            
            struct Singleton {
                static var sharedInstance = ParseLogin()
            }
            return Singleton.sharedInstance
        }
        
  
}