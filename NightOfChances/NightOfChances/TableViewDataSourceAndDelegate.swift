//
//  TableViewDataSourceAndDelegate.swift
//  NightOfChances
//
//  Created by Jakub Blahut on 23/10/16.
//  Copyright © 2016 Jakub Blahut. All rights reserved.
//

import UIKit

class TableViewDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") ?? UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        
        cell.textLabel?.text = "cell \(indexPath.row)"
        cell.detailTextLabel?.text = "\(indexPath.row) subtitle"
        
        return cell
    }
    
}

