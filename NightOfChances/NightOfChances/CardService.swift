//
//  CardService.swift
//  NightOfChances
//
//  Created by fillky on 25.10.2016.
//  Copyright © 2016 Jakub Blahut. All rights reserved.
//

import UIKit

class CardService: Service {
    
    func blockCard(_ card: Card) -> Bool {
        return performPUT(URL(string: "https://api.csas.cz/cards/\(card.id)/activate")!)
    }

}
