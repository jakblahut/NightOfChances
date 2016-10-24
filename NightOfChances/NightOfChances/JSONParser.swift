//
//  JSONParser.swift
//  NightOfChances
//
//  Created by Jakub Blahut on 24/10/16.
//  Copyright © 2016 Jakub Blahut. All rights reserved.
//

import UIKit

typealias parseCompletionBlock = ([Card]?) -> ()

class JSONParser: NSObject {
    
    func parseData(data: NSData, completionBlock: parseCompletionBlock) {
        var jsonData: [String: AnyObject]!
        
        do {
            jsonData = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject]
        } catch {
            print(error)
            completionBlock(nil)
            return
        }
        
        guard let cardsData = jsonData["cards"] as? [[String: AnyObject]] else {
            completionBlock(nil)
            return
        }
        
        var cards: [Card] = []
        
        for cardData in cardsData {
            
            let id = cardData["id"] as! String
            let number = cardData["number"] as! String
            
            let card = Card(id: id, number: number)
            cards.append(card)
        }
        
        completionBlock(cards)
    }

}
