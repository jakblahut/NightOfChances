//
//  ViewController.swift
//  NightOfChances
//
//  Created by Jakub Blahut on 23/10/16.
//  Copyright © 2016 Jakub Blahut. All rights reserved.
//

import UIKit

class ViewControllerSB: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "cell \(indexPath.row)"
        cell.detailTextLabel?.text = "\(indexPath.row) subtitle"
        
        return cell
    }
    
}
