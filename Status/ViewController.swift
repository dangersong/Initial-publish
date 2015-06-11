//
//  ViewController.swift
//  Status
//
//  Created by dave on 6/8/15.
//  Copyright (c) 2015 dave. All rights reserved.
//

import UIKit

// Common error that a method is missing, CMD click and copy over and override required methods
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // Add array to store updates
    var updates = [Update]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        let urlString = "https://rawgit.com/jamescmartinez/Status/master/updates.json"
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        let connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Grabbing the first item from the array from the xibx
        var cell = NSBundle.mainBundle().loadNibNamed("UpdateTableViewCell", owner: self, options: nil).first as! UpdateTableViewCell
        
//        // TODO: Make this cell reuseable
//        // Below is a bad example as we are not reusing cells
//        var cell = UpdateTableViewCell()
        
        var update = updates[indexPath.row]
        cell.updateTableView?.text = update.text
        
        if let user = update.user {
            cell.updateUsername.text = user.username
        }
        
        if let date = update.date {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "h:mm a" // superset of OP's format
            let str = dateFormatter.stringFromDate(date)
            cell.updateDate?.text = str
        }

        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    
    // MARK: - NSURLConnectionDelegate
    // NSURL function will automatically call connect
    
    // Method signature (name)
    // connection:didReceiveData:
    // this is a delegate function!
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        println(connection)
        println(data)

        let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSArray
            println(jsonObject)
        
        for var i = 0; i < jsonObject.count; i++ {
            // setting json object as a dictionary
            let updateJSON = jsonObject[i] as! [String: AnyObject]
            let text = updateJSON["text"] as! String
            let date = updateJSON["date"] as! Int
            let userJSON = updateJSON["user"] as! [String: AnyObject]
            let name = userJSON["name"] as! String
            let username = userJSON["username"] as! String
            let bio = userJSON["bio"] as! String
            let link = userJSON["link"] as! String
            let city = userJSON["city"] as! String
//            println(userJSON)

            var user = User()
            user.username = username
            user.bio = bio
            user.city = city
            user.link = link

            var update = Update()
            update.user = user
            update.text = text
            // TODO: convert date integer to NSDate
            update.date = NSDate()
            
            updates.append(update)
        }
        tableView.reloadData()
    }
}








class SomeClass {
    func createPlist() {
        // Get a reference to the Documents Directory with User permissions
        // For example: /Users/james/Documents
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        // Get the first path (only one Documents Directory)
        let firstPath = paths.first as! String
        // Add 'data.plist' onto the Documents Directory path
        // For example: /Users/james/Documents/data.plist
        let plistPath = firstPath.stringByAppendingPathComponent("data.plist")
        // Create a reference to the file manager
        let fileManager = NSFileManager.defaultManager()
        // Check to see if the plist exists
        if !fileManager.fileExistsAtPath(plistPath) {
            // TODO: create plist
//        let pleaseSucceed = data.writeToFile(plistPath, atomically: true)
            // An array converted to an NSArray (an object)
            let updatesObject = updates as NSArray
            updatesObject.writeToFile(plistPath, atomically: true)
            let plistData = NSArray(contentsOfFile: plistPath)
        }
        // Write my data to the plist
        let myData = NSData()
        myData.writeToFile(plistPath, atomically: true)
    }
}






