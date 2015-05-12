//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Edward Stamps on 4/13/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
   
    
    
    
    @IBOutlet weak var userNameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var debugTextLabel: UILabel!
    
    var appDelegate: AppDelegate!
    var session: NSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameText.delegate = self
        passwordText.delegate = self
        
        /* Get the app delegate */
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        /* Get the shared URL session */
        session = NSURLSession.sharedSession()
        
        /* Configure the UI */
       //self.configureUI()
        
        
    }
    
 
    
    @IBAction func loginButton(sender: AnyObject) {
        
        if userNameText.text.isEmpty {
            debugTextLabel.text = "Username Empty."
        } else if passwordText.text.isEmpty {
            debugTextLabel.text = "Password Empty."
        } else {
            self.textFieldShouldReturn(passwordText)
            
            /*
            Steps for Authentication...
           
            
            Step 1: Create a new request token
            Step 2: Ask the user for permission via the API ("login")
            Step 3: Create a session ID
            
            Extra Steps...
            Step 4: Go ahead and get the user id ;)
            Step 5: Got everything we need, go to the next view!
            
            */
            //self.getSessionID()
           // UdacityLogin.setSessionID(){
            self.appDelegate.loginID = self.userNameText.text
            self.appDelegate.passwordID = self.passwordText.text
           self.loginNew()
                
           // }
        }
    
    }
    
    func completeLogin() {
        dispatch_async(dispatch_get_main_queue(), {
            self.debugTextLabel.text = ""
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarViewController") as! UIViewController
            self.presentViewController(controller, animated: true, completion: nil)
        })
    }
    
    func loginNew() {
    
        UdacityLogin.sharedInstance().authenticateWithViewController(self) { (success) in
    if success {
    self.completeLogin()
        self.appDelegate.loginID = ""
        self.appDelegate.passwordID = ""
    } else {
        self.displayError()
    }
    }
    }
    
    
    func displayError() {
        dispatch_async(dispatch_get_main_queue(), {
           
                self.debugTextLabel.text = self.appDelegate.errorString!
           
        })
    }

    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
   
        if textField==userNameText{
            userNameText.resignFirstResponder()
            passwordText.becomeFirstResponder()
        }
        else if textField==passwordText {
            passwordText.resignFirstResponder()
        }
        
        return true;
        
    }
    
 


}



//
//    func getSessionID() {
//
//        //UdacityLogin.setSessionID() {
//
//        //1. set parameters
////        let methodParameters = [
////            UdacityLogin.loginID = userNameText.text,
////            UdacityLogin.passwordID = passwordText.text
////
////        ]
//
//        let mydataUser = "{\"udacity\": {\"username\": \"" + self.userNameText.text + "\", \"password\": \"" + self.passwordText.text + "\"}}"
//       // println(mydataUser)
//
//        //3. configure request. hardcoded URL string
//
//        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
//        request.HTTPMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.HTTPBody = mydataUser.dataUsingEncoding(NSUTF8StringEncoding)
//        let session = NSURLSession.sharedSession()
//
//       // println(request.HTTPBody)
//
//        //4. make request
//
//        let task = session.dataTaskWithRequest(request) { data, response, error in
//            if error != nil { // Handle error…
//                self.debugTextLabel.text = "Login Failed"
//
//                return
//            }
//
//
//
//
//
//            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
//
//            var parsingError: NSError? = nil
//            let parsedResult = NSJSONSerialization.JSONObjectWithData(newData, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
//
//          //  println(parsedResult)
//
//                    if let account: AnyObject = parsedResult["account"] {
//                        if var sessionIDnow: AnyObject? = account["key"]{
//                           // sessionIDnow = sessionIDnow[2,4]
//                            self.appDelegate.sessionID = sessionIDnow
//                          self.getUserID(self.appDelegate.sessionID! as! String)
//
//                       println(self.appDelegate.sessionID)
//
//
//                        }
//                    }
//           }
//        task.resume()
//
//
//    }
//
//
//    func getUserID(sessionID: String) {
//
//       let userID: AnyObject! = self.appDelegate.sessionID
//
//        //println(userID)
//        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/users/" + "\(userID!)")!)
//     //   println(request)
//            let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithRequest(request) { data, response, error in
//            if error != nil { // Handle error...
//                self.debugTextLabel.text = "Error reaching network"
//                return
//            }
//            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
//            println(NSString(data: newData, encoding: NSUTF8StringEncoding))
//
//            var parsingError: NSError? = nil
//            let parsedResult = NSJSONSerialization.JSONObjectWithData(newData, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
//          //  println(parsedResult)
//
//            if let account: AnyObject = parsedResult["user"] {
//                var userIDnow = account["first_name"] as! String
//                var userIDnow2 = account["last_name"] as! String
//                var userIDnow3 = userIDnow + " " + userIDnow2
//                self.appDelegate.firstNameID = userIDnow
//                self.appDelegate.lastNameID = userIDnow2
//                self.appDelegate.nameID = userIDnow3
//                println(userIDnow3)
//                self.completeLogin()
//                }
//
//        }
//        task.resume()
//
//    }


