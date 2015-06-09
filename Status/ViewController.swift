//
//  ViewController.swift
//  Status
//
//  Created by dave on 6/8/15.
//  Copyright (c) 2015 dave. All rights reserved.
//

import UIKit

// Common error that a method is missing, CMD click and copy over and override required methods
class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    // Add array to store updates
    var updates: [Update]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        // TODO: Sample data, remove when getting real data
        
        // Initialize updates to a brand new array
        updates = [Update]()
        
        var user = User()
        user.username = "James"
        user.bio = "Him"
        user.city = "San Francisco"
        user.link = "http://somewebsite.com"
        
        for var i = 0; i < 100; i++ {
            var update = Update()
            update.date = NSDate()
            update.text = "Hello world! \(i)"
            update.user = user
        
            updates?.append(update)
        }
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
 
        // TODO: Make this cell reuseable
        // Below is a bad example as we are not reusing cells
        var cell = UITableViewCell()
        
        // Very often people will call their "if lets" as the very same thing they're looking for
        if let updates = updates {
            var update = updates[indexPath.row]
            cell.textLabel?.text = update.text
        }
        return cell
    }
}





