//
//  ViewControllerNoSB.swift
//  NightOfChances
//
//  Created by Jakub Blahut on 23/10/16.
//  Copyright © 2016 Jakub Blahut. All rights reserved.
//

import UIKit

class ViewControllerNoSB: UIViewController {
    
    let tableView = UITableView()
    
    var dataSourceAndDelegate: TableViewDataSourceAndDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Night Of Chances"
        view.backgroundColor = UIColor.whiteColor()

        dataSourceAndDelegate = TableViewDataSourceAndDelegate(rootViewController: self, tableView: tableView)
        tableView.dataSource = dataSourceAndDelegate
        tableView.delegate = dataSourceAndDelegate
        
        view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
}
