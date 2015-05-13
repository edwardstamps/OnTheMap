//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Edward Stamps on 4/15/15.
//  Copyright (c) 2015 CheckList. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    
    var appDelegate: AppDelegate!
    


    
    var students: [Student] = [Student]()
  
   
    
   
    
    @IBOutlet weak var debugText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.studentEntry()
       
        }
        
        
    @IBAction func newPin(sender: AnyObject) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("NewPinViewController") as! UIViewController
        self.navigationController!.pushViewController(controller, animated: true)
        
    }
        
 
    @IBAction func refreshPage(sender: AnyObject) {
        self.studentEntry()
    }
       
    
    
    
    func studentEntry() {
    let parsedResult = self.appDelegate.dataStuff as! NSDictionary
        println(parsedResult)
    if let results = parsedResult["results"] as? [[String : AnyObject]] {
      self.students = Student.studentsFromResults(results)
      
        }
    else {
        self.debugText.text = "Error Showing Results"
        }
  }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return students.count
        }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! UITableViewCell
            let student = students[indexPath.row]
            cell.textLabel?.text = student.title
            return cell
        }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let linker = self.students[indexPath.row]
        let launchOptions = UIApplication.sharedApplication().openURL(NSURL(string: linker.theUrl)!)
    }
    
}
