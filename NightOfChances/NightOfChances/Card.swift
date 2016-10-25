//
//  Card.swift
//  NightOfChances
//
//  Created by Jakub Blahut on 24/10/16.
//  Copyright © 2016 Jakub Blahut. All rights reserved.
//

import UIKit

struct Card {
    let id: String
    let number: String
    let owner: String
    let product: String
    let balance: NSDecimalNumber
    let limit: NSDecimalNumber
    let currency: String
    let actions: Array<String>
}
