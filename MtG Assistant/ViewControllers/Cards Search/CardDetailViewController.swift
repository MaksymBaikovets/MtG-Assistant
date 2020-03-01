//
//  CardDetailViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 01.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {

    var data: Displayable?
    var listData: [Displayable] = []
    
    // -------------------------------------------------------------------
    // MARK: Outlets
    // -------------------------------------------------------------------
    
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardType: UILabel!
    @IBOutlet weak var oracleText: UILabel!
    
    @IBOutlet weak var flavorTextTitle: UILabel!
    @IBOutlet weak var flavorText: UILabel!
    
    // -------------------------------------------------------------------
    // MARK: commonInit
    // -------------------------------------------------------------------
    
    private func commonInit() {
        guard let data = data else { return }

        cardName.text = data.name
        cardType.text = data.typeLine

        oracleText.text = data.oracleText
        if data.flavorText == nil {
            flavorTextTitle.isHidden = true
            flavorText.isHidden = true
        } else {
            flavorText.text = data.flavorText
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}
