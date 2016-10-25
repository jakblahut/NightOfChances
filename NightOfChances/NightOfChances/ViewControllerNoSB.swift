//
//  ViewControllerNoSB.swift
//  NightOfChances
//
//  Created by Jakub Blahut on 23/10/16.
//  Copyright © 2016 Jakub Blahut. All rights reserved.
//

import UIKit

class ViewControllerNoSB: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    
    let dataSourceAndDelegate = TableViewDataSourceAndDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Night Of Chances"
        view.backgroundColor = UIColor.whiteColor()

        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") ?? UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = "cell \(indexPath.row)"
        cell.detailTextLabel?.text = "\(indexPath.row) subtitle"
        
        return cell
    }
    
}
