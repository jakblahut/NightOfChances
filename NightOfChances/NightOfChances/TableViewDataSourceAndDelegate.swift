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
        
//        let structVsClass = StructVsClass()
//        structVsClass.doMagic()
    }
    
    private func createModel(tableViewToUpdate: UITableView) {
        let jsonParser = JSONParser()
        let url = NSBundle.mainBundle().URLForResource("cards", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            jsonParser.parseData(data!) { [weak self] (cards) in
                if let cards = cards {
                    for card in cards {
                        let cardTableModel = CardTableModel(title: card.id, subTitle: card.number, card: card)
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
        let cardDetailViewController = CardDetailViewController(card: cardTableModels[indexPath.row].card)
        
        rootViewController?.navigationController?.pushViewController(cardDetailViewController, animated: true)
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: false)
    }
    
    func cardDetailViewControllerButtonTapped() {
        rootViewController?.navigationController?.popViewControllerAnimated(true)
    }
    
}


//class StructVsClass: NSObject {
//    
//    struct CustomStruct {
//        var variable = ""
//    }
//    
//    class CustomClass {
//        var variable = ""
//    }
//    
//    func doMagic() {
//        var s1 = CustomStruct()
//        var s2 = CustomStruct()
//        
//        let c1 = CustomClass()
//        var c2 = CustomClass()
//        
//        s1.variable = "struct 1"
//        s2 = s1
//        s2.variable = "struct 2"
//        
//        c1.variable = "class 1"
//        c2 = c1
//        c2.variable = "class 2"
//        
//        print("s1 = \(s1.variable) .... c1 = \(c1.variable)")
//    }
//    
//}

