//
//  NewPinViewController.swift
//  OnTheMap
//
//  Created by Edward Stamps on 4/21/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class NewPinViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate {
    
    var session: NSURLSession!
    
    var location: CLLocation!
    
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var backView2: UIView!
    @IBOutlet weak var questionOne: UILabel!
    
    @IBOutlet weak var questionOneA: UILabel!
    
    @IBOutlet weak var questionOneB: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var linkTextField: UITextField!
    
    @IBOutlet weak var backView3: UIView!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var submit: UIButton!
    
    @IBOutlet weak var mapSubmit: UIButton!
    
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        linkTextField.delegate = self
        cityTextField.delegate = self
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        session = NSURLSession.sharedSession()
       
        submit.hidden = true
        
        var firstName = self.appDelegate.firstNameID!
        var lastName = self.appDelegate.lastNameID!
        mapView.hidden = true
        linkTextField.hidden = true
        activityInd.hidden = true
        
        
        
        
        
        
    
        
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        //self.tabBarItem.hidden = false
         self.navigationController!.popViewControllerAnimated(true)
    }
   
    

    @IBAction func findMapButton(sender: AnyObject) {
        if cityTextField.text.isEmpty {
            cityTextField.text = "Please Search"}
        else {
            mapView.hidden = false
            activityInd.hidden=false
            activityInd.startAnimating()
        var address = cityTextField.text!
        
            var geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
                
                if let placemark = placemarks?[0] as? CLPlacemark {
                    self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
                    self.appDelegate.locationInfo = placemark.location
                    
                
                }
                self.activityInd.stopAnimating()
                self.activityInd.hidden=true
                
            })

        }
        
        
        mapSubmit.hidden=true
        backView2.hidden=true
        backView3.hidden=true
        submit.hidden = false
        cityTextField.hidden = true
       questionOne.hidden = true
        questionOneA.hidden=true
        questionOneB.hidden = true
        linkTextField.hidden = false
        backgroundView.backgroundColor = UIColor.blueColor()
        
    }
    
    func loginNew() {
        
        ParseLogin.sharedInstance().authenticateWithViewController(self) { (success) in
            if success {
                self.completeLogin()
            } else {
                
            }
        }
    }
    
    
 
    @IBAction func SubmitButton(sender: AnyObject) {
        self.textFieldShouldReturn(linkTextField)
        var urlnew  = linkTextField.text!
        let validURL: NSURL = NSURL(string: urlnew)!
        if UIApplication.sharedApplication().canOpenURL(validURL) {
            let locationIntel = self.appDelegate.locationInfo!
            self.appDelegate.linkInfo = urlnew
            self.appDelegate.cityInfo = cityTextField.text!
            loginNew()
            
        }
        
        else {
        self.linkTextField.text = "Please Enter Valid URL"
        }
    }

    func completeLogin() {
        dispatch_async(dispatch_get_main_queue(), {
            
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarViewController") as! UIViewController
            self.presentViewController(controller, animated: true, completion: nil)
        })
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? MapPin {
            
            let identifier = "pin"
            var view: MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
                    
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            
            return view
            
            
        }
        return nil
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        if textField == linkTextField{
            linkTextField.resignFirstResponder()
        }
        if textField == cityTextField{
            cityTextField.resignFirstResponder()
        }
        
        return true;
    }
}
    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        if linkTextField.text == "Enter a Link to Share Here"{
//            linkTextField.text = ""
//        }
//    }
    //        println(locationIntel.coordinate.latitude)
    //
    //        let latitudeIntel = locationIntel.coordinate.latitude as Double
    //        let longitudeIntel = locationIntel.coordinate.longitude as Double
    //
    //        let sessionID = "{\"uniqueKey\": \"" + (self.appDelegate.sessionID! as! String) + "\", \"firstName\": \""
    //        let mydataUser = self.appDelegate.firstNameID! + "\", \"lastName\": \"" + self.appDelegate.lastNameID! + "\",\"mapString\": \""
    //        let mydataUser2 = self.cityTextField.text + "\", \"mediaURL\": \"" + linkTextField.text + "\","
    //        let mydataUser3 = "\"latitude\": " + "\(latitudeIntel)" + ", \"longitude\": " + "\(longitudeIntel)" + "}"
    //        let mydataUser4 = sessionID + mydataUser + mydataUser2 + mydataUser3
    //        let money = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}"
    //
    //      //  println(mydataUser4)
    //    //    println(money)
    //
    //        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
    //        request.HTTPMethod = "POST"
    //        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    //        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //        request.HTTPBody = mydataUser4.dataUsingEncoding(NSUTF8StringEncoding)
    //
    //        let session = NSURLSession.sharedSession()
    //        let task = session.dataTaskWithRequest(request) { data, response, error in
    //            if error != nil { // Handle error…
    //                return
    //            }
    //        //    println(NSString(data: data, encoding: NSUTF8StringEncoding))
    //            self.completeLogin()
    //
    //
    //
    //        }
    //
    //        task.resume()
    //        }
    
    // }
    
    //    func newLocation() {
    //        let urlString = "https://api.parse.com/1/classes/StudentLocation/VHtxyNainb"
    //        let url = NSURL(string: urlString)
    //        let request = NSMutableURLRequest(URL: url!)
    //        request.HTTPMethod = "PUT"
    //        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    //        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //        request.HTTPBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Cupertino, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.322998, \"longitude\": -122.032182}".dataUsingEncoding(NSUTF8StringEncoding)
    //        let session = NSURLSession.sharedSession()
    //        let task = session.dataTaskWithRequest(request) { data, response, error in
    //            if error != nil { // Handle error…
    //                return
    //            }
    //            println(NSString(data: data, encoding: NSUTF8StringEncoding))
    //        }
    //        task.resume()
    //    }
    

    



