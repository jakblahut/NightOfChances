//
//  CardService.swift
//  NightOfChances
//
//  Created by fillky on 25.10.2016.
//  Copyright © 2016 Jakub Blahut. All rights reserved.
//

import UIKit

class CardService: Service {
    
    func blockCard(card: Card) -> Bool {
        return performPUT(NSURL(string: "https://api.csas.cz/cards/\(card.id)/activate")!)
    }

}
