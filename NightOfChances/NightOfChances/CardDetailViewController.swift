//
//  CardDetailViewController.swift
//  NightOfChances
//
//  Created by Jakub Blahut on 23/10/16.
//  Copyright © 2016 Jakub Blahut. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // TODO: access levels
    let tableView: UITableView
    // TODO: make immutable
    var card: Card
    
    init(card: Card) {
        self.card = card
        //TODO: 1. refactor zero 2. move initialization to declaration
        self.tableView = UITableView(frame: CGRectMake(0, 0, 0, 0), style: .Grouped)
        
        super.init(nibName: nil, bundle: nil)
        
        // TODO: move to bindVariales
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // TODO: refactor with bounds
        // Q: table initialization methods
        self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 5
        case 1: return card.actions.count
        default: return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch section {
        case 0: return "Info"
        case 1: return "Actions"
        default: return "No Title"
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // TODO: refactor using const identifier
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("DetailCell") ?? UITableViewCell(style: .Value1, reuseIdentifier: "DetailCell")
        
        if indexPath.section == 0 {
            
            cell.selectionStyle = .None
            
            // TODO: refactor if statements
            // TODO: move to configure method
            if indexPath.row == 0 {
                cell.textLabel?.text = "Card"
                cell.detailTextLabel?.text = card.product
            }
            
            if indexPath.row == 1 {
                cell.textLabel?.text = "Number"
                cell.detailTextLabel?.text = card.number
            }
            
            if indexPath.row == 2 {
                cell.textLabel?.text = "Owner"
                cell.detailTextLabel?.text = card.owner
            }
            
            if indexPath.row == 3 {
                //TODO: refactor DRY
                cell.textLabel?.text = "Balance"
                let formatter = NSNumberFormatter()
                formatter.numberStyle = .DecimalStyle;
                formatter.minimumFractionDigits = 2;
                formatter.maximumFractionDigits = 2;
                formatter.usesGroupingSeparator = true;
                formatter.groupingSeparator = " ";
                formatter.decimalSeparator = ",";
                cell.detailTextLabel?.text = "\(formatter.stringFromNumber(card.balance)!) \(card.currency)"
                
            }
            
            if indexPath.row == 4 {
                // TODO: refactor formatter allocation
                cell.textLabel?.text = "Limit"
                let formatter = NSNumberFormatter()
                formatter.numberStyle = .DecimalStyle;
                formatter.minimumFractionDigits = 2;
                formatter.maximumFractionDigits = 2;
                formatter.usesGroupingSeparator = true;
                formatter.groupingSeparator = " ";
                formatter.decimalSeparator = ",";
                cell.detailTextLabel?.text = "\(formatter.stringFromNumber(card.limit)!) \(card.currency)"
            }
        }
        
        if indexPath.section == 1 {
            // TODO: refactor
            cell = tableView.dequeueReusableCellWithIdentifier("DetailCell") ?? UITableViewCell(style: .Default, reuseIdentifier: "DetailCell")
            cell.accessoryType = .DisclosureIndicator
            cell.selectionStyle = .Gray
            
            // TODO: enum + switch
            if card.actions[indexPath.row] == "lock" {
                cell.textLabel?.text = "Lock"
            } else if card.actions[indexPath.row] == "block" {
                cell.textLabel?.text = "Block"
            } else if card.actions[indexPath.row] == "deactivate" {
                cell.textLabel?.text = "Deactivate"
            } else if card.actions[indexPath.row] == "increaseAmount" {
                cell.textLabel?.text = "Increase Amount"
            } else if card.actions[indexPath.row] == "increaseLimit" {
                cell.textLabel?.text = "Increase Limit"
            }
            // TODO: assert
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // TODO: logic based on function not index
        let function = card.actions[indexPath.row]
        
        if function == "block" {
            self.blockCard()
            return
        }
        
        // TODO: move to macro
        let alert = UIAlertController(title: "Not Implemented", message: "Card function not implemented yet", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(ok)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // TODO: move to model and take card as argument
    func blockCard() {
        let blockAlert = UIAlertController(title: "Are you sure you want to block this card?", message: nil, preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let blockAction = UIAlertAction(title: "Block", style: .Destructive) { (action) in
            // TODO: refactor name
            CardService().blockCard(self.card)
        }
        blockAlert.addAction(blockAction)
        blockAlert.addAction(cancelAction)
        presentViewController(blockAlert, animated: true, completion: nil)
    }
}
