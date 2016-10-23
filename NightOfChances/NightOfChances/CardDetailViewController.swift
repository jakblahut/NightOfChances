//
//  CardDetailViewController.swift
//  NightOfChances
//
//  Created by Jakub Blahut on 23/10/16.
//  Copyright © 2016 Jakub Blahut. All rights reserved.
//

import UIKit

protocol CardDetailViewControllerDelegate {
    func cardDetailViewControllerButtonTapped()
}

class CardDetailViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    var delegate: CardDetailViewControllerDelegate?
    
    init() {
        super.init(nibName: "CardDetailViewController", bundle: NSBundle.mainBundle())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
    }

    @objc func buttonTapped() {
        delegate?.cardDetailViewControllerButtonTapped()
    }
}
