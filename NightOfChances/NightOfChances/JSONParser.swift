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
            let owner = cardData["owner"] as! String
            let product = cardData["product"] as! String
            let balanceDic = cardData["balance"] as! [String: AnyObject]
            let balanceVal = balanceDic["value"] as! NSNumber
            let balancePrec = balanceDic["precision"] as! NSNumber
            let limitDic = cardData["limit"] as! [String: AnyObject]
            let limitVal = limitDic["value"] as! NSNumber
            let limitPrec = limitDic["precision"] as! NSNumber
            let balance = NSDecimalNumber(mantissa: balanceVal.unsignedLongLongValue, exponent: Int16(balancePrec.intValue), isNegative: false)
            let limit = NSDecimalNumber(mantissa: limitVal.unsignedLongLongValue, exponent: Int16(limitPrec.intValue), isNegative: false)
            let currency = balanceDic["currency"] as! String
            let actionsDic = cardData["actions"] as! [String: Int]
            var actions: [String] = Array()
            for key in actionsDic.keys {
                if actionsDic[key] == 1 {
                    actions.append(key)
                }
            }
            
            let card = Card(id: id, number: number, owner: owner, product: product, balance: balance, limit: limit, currency: currency, actions: actions)
            cards.append(card)
        }
        
        completionBlock(cards)
    }

}
