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
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        
        super.init(nibName: nil, bundle: nil)
        
        // TODO: move to bindVariales
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // TODO: refactor with bounds
        // Q: table initialization methods
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 5
        case 1: return card.actions.count
        default: return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch section {
        case 0: return "Info"
        case 1: return "Actions"
        default: return "No Title"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // TODO: refactor using const identifier
        var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") ?? UITableViewCell(style: .value1, reuseIdentifier: "DetailCell")
        
        if indexPath.section == 0 {
            
            cell.selectionStyle = .none
            
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
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal;
                formatter.minimumFractionDigits = 2;
                formatter.maximumFractionDigits = 2;
                formatter.usesGroupingSeparator = true;
                formatter.groupingSeparator = " ";
                formatter.decimalSeparator = ",";
                cell.detailTextLabel?.text = "\(formatter.string(from: card.balance)!) \(card.currency)"
                
            }
            
            if indexPath.row == 4 {
                // TODO: refactor formatter allocation
                cell.textLabel?.text = "Limit"
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal;
                formatter.minimumFractionDigits = 2;
                formatter.maximumFractionDigits = 2;
                formatter.usesGroupingSeparator = true;
                formatter.groupingSeparator = " ";
                formatter.decimalSeparator = ",";
                cell.detailTextLabel?.text = "\(formatter.string(from: card.limit)!) \(card.currency)"
            }
        }
        
        if indexPath.section == 1 {
            // TODO: refactor
            cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") ?? UITableViewCell(style: .default, reuseIdentifier: "DetailCell")
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .gray
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // TODO: logic based on function not index
        let function = card.actions[indexPath.row]
        
        if function == "block" {
            self.blockCard()
            return
        }
        
        // TODO: move to macro
        let alert = UIAlertController(title: "Not Implemented", message: "Card function not implemented yet", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    // TODO: move to model and take card as argument
    func blockCard() {
        let blockAlert = UIAlertController(title: "Are you sure you want to block this card?", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let blockAction = UIAlertAction(title: "Block", style: .destructive) { (action) in
            // TODO: refactor name
            CardService().blockCard(self.card)
        }
        blockAlert.addAction(blockAction)
        blockAlert.addAction(cancelAction)
        present(blockAlert, animated: true, completion: nil)
    }
}
