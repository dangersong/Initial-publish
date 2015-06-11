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
    var updates: [Update]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        let urlString = "https://rawgit.com/jamescmartinez/Status/master/updates.json"
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        let connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        
        // TODO: Sample data, remove when getting real data
        
        // Initialize updates to a brand new array
//        updates = [Update]()
//        
//        var user = User()
//        user.username = "James"
//        user.bio = "Him"
//        user.city = "San Francisco"
//        user.link = "http://somewebsite.com"
//        
//        for var i = 0; i < 100; i++ {
//            var update = Update()
//            update.date = NSDate()
//            update.text = "Hello world! \(i)"
//            update.user = user
//        
//            updates?.append(update)
//        }
    }
    
    // MARK: - UITableViewDataSource
    // This marker goes until the end of the of the file or another marker
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Typically return a count of something
        
        // TODO: Return count of update items
        if let updatesCount = updates?.count {
            return updatesCount
        }
        
        // Another option to test for nil
//        if updates.count != nil {
//            
//        }

        // Short circuiting with "return". Exits code block once return line is run.
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Grabbing the first item from the array from the xibx
        var cell = NSBundle.mainBundle().loadNibNamed("UpdateTableViewCell", owner: self, options: nil).first as! UpdateTableViewCell
        
//        // TODO: Make this cell reuseable
//        // Below is a bad example as we are not reusing cells
//        var cell = UpdateTableViewCell()
        
        
//         Changed this to reference our custom view, UpdateTableViewCell
//        var cell = UITableViewCell()
        
        // Very often people will call their "if lets" as the very same thing they're looking for
        if let updates = updates {
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
        
        updates = [Update]()
        
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
            
            updates?.append(update)
        }
        tableView.reloadData()
    }
}