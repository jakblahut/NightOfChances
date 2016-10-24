//
//  TableViewDataSourceAndDelegate.swift
//  NightOfChances
//
//  Created by Jakub Blahut on 23/10/16.
//  Copyright © 2016 Jakub Blahut. All rights reserved.
//

import UIKit

struct CardTableModel {
    let title: String
    let subTitle: String
}

class TableViewDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate, CardDetailViewControllerDelegate {
    
    weak var rootViewController: UIViewController?
    var cardTableModels: [CardTableModel] = []
    
    init(rootViewController: UIViewController, tableView: UITableView) {
        self.rootViewController = rootViewController
        
        super.init()
        
        createModel(tableView)
    }
    
    private func createModel(tableViewToUpdate: UITableView) {
        let jsonParser = JSONParser()
        let url = NSBundle.mainBundle().URLForResource("cards", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            jsonParser.parseData(data!) { [weak self] (cards) in
                if let cards = cards {
                    for card in cards {
                        let cardTableModel = CardTableModel(title: card.id, subTitle: card.number)
                        self?.cardTableModels.append(cardTableModel)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        tableViewToUpdate.reloadData()
                    })
                }
            }
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardTableModels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") ?? UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        
        cell.textLabel?.text = cardTableModels[indexPath.row].title
        cell.detailTextLabel?.text = cardTableModels[indexPath.row].subTitle
        
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
