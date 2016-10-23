//
//  TableViewDataSourceAndDelegate.swift
//  NightOfChances
//
//  Created by Jakub Blahut on 23/10/16.
//  Copyright © 2016 Jakub Blahut. All rights reserved.
//

import UIKit

class TableViewDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate, CardDetailViewControllerDelegate {
    
    weak var rootViewController: UIViewController?
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") ?? UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cardDetailViewController = CardDetailViewController()
        cardDetailViewController.delegate = self
        
        rootViewController?.navigationController?.pushViewController(cardDetailViewController, animated: true)
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: false)
    }
    
    func cardDetailViewControllerButtonTapped() {
        rootViewController?.navigationController?.popViewControllerAnimated(true)
    }
    
}
