//
//  ViewControllerNoSB.swift
//  NightOfChances
//
//  Created by Jakub Blahut on 23/10/16.
//  Copyright © 2016 Jakub Blahut. All rights reserved.
//

import UIKit

class ViewControllerNoSB: UIViewController, UITableViewDataSource, UITableViewDelegate, CardDetailViewControllerDelegate {
    
    let tableView = UITableView()

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
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") ?? UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cardDetailViewController = CardDetailViewController()
        cardDetailViewController.delegate = self
        
        navigationController?.pushViewController(cardDetailViewController, animated: true)
    }
    
    func cardDetailViewControllerButtonTapped() {
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: false)
        navigationController?.popViewControllerAnimated(true)
    }
    
}
