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
    let card: Card
}

class TableViewDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var rootViewController: UIViewController?
    var cardTableModels: [CardTableModel] = []
    
    init(rootViewController: UIViewController, tableView: UITableView) {
        self.rootViewController = rootViewController
        
        super.init()
        
        createModel(tableView)
    }
    
    fileprivate func createModel(_ tableViewToUpdate: UITableView) {
        let jsonParser = JSONParser()
        let url = Bundle.main.url(forResource: "cards", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
            jsonParser.parseData(data!) { [weak self] (cards) in
                if let cards = cards {
                    for card in cards {
                        let cardTableModel = CardTableModel(title: card.id, subTitle: card.number, card: card)
                        self?.cardTableModels.append(cardTableModel)
                    }
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        tableViewToUpdate.reloadData()
                    })
                }
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardTableModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        cell.textLabel?.text = cardTableModels[indexPath.row].title
        cell.detailTextLabel?.text = cardTableModels[indexPath.row].subTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cardDetailViewController = CardDetailViewController(card: cardTableModels[indexPath.row].card)
        
        rootViewController?.navigationController?.pushViewController(cardDetailViewController, animated: true)
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: false)
    }
    
    func cardDetailViewControllerButtonTapped() {
        rootViewController?.navigationController?.popViewController(animated: true)
    }
    
}

