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
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    
    // MARK: - UITableViewDataSource
    // This marker goes until the end of the of the file or another marker
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Typically return a count of something
        
        // TODO: Return count of update items
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
 
        // TODO: Make this cell reuseable
        
        
        // Below is a bad example as we are not reusing cells
        var cell = UITableViewCell()
        return cell
    }
}