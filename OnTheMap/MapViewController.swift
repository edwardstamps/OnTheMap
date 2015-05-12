//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Edward Stamps on 4/15/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
 
 
    
    var appDelegate: AppDelegate!
    var session: NSURLSession!
    
    var pins = [MapPin]()
    

    @IBOutlet weak var debugText: UILabel!
    
   
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        /* Get the shared URL session */
        session = NSURLSession.sharedSession()
        
        /* Configure the UI */
        //self.getUserInfo()
        
        self.loginNew()
        
        
 
        
    }
    
    
    
    @IBAction func refreshPage(sender: AnyObject) {
        self.studentEntry()
    }
    
    @IBAction func addNewPin(sender: AnyObject) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("NewPinViewController") as! UIViewController
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    func loginNew() {
        
        ParseLogin.sharedInstance().authenticateWithViewController(self) { (success) in
            if success {
                self.studentEntry()
            } else {
                self.debugText.text = self.appDelegate.errorString!
            }
        }
    }
  
    func studentEntry() {
        let parsedResult = self.appDelegate.dataStuff as! NSDictionary
        if let results = parsedResult["results"] as? [[String : AnyObject]] {
            pins = MapPin.pinsFromResults(results)
          //  println(pins)
            dispatch_async(dispatch_get_main_queue()) {
           self.mapView.addAnnotations(self.pins)
            }
        
        }
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
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!,
        calloutAccessoryControlTapped control: UIControl!) {
            let linker = view.annotation as! MapPin
            let launchOptions = UIApplication.sharedApplication().openURL(NSURL(string: linker.subtitle)!)
            
    }
    
}


//    func getUserInfo() {
//        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
//        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
//        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithRequest(request) { data, response, error in
//            if error != nil { // Handle error...
//                self.debugText.text = "Load Error. Please refresh"
//                return
//            }
//          // let newData = (NSString(data: data, encoding: NSUTF8StringEncoding))
//            var parsingError: NSError? = nil
//            let parsedResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil ) as! [String : AnyObject]
//            self.appDelegate.dataStuff = parsedResult
//       println(self.appDelegate.dataStuff)
//           // self.UserInfo()
//          //self.tranList()
//            self.studentEntry()
//        }
//        task.resume()
//    }
//

