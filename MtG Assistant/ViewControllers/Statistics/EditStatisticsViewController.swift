//
//  EditStatisticsViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 26.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit
import CoreData

class EditStatisticsViewController: UITableViewController, UITextFieldDelegate {

    var coreHeadlines: [NSManagedObject] = []
    var data: StatisticsHeadline?
    
    // -------------------------------------------------------------------
    // MARK: Outlets
    // -------------------------------------------------------------------
    
    @IBOutlet weak var firstPlayerName: TextField!
    @IBOutlet weak var secondPlayerName: TextField!
    
    @IBOutlet weak var firstPlayerDeck: TextField!
    @IBOutlet weak var secondPlayerDeck: TextField!
    
    @IBOutlet weak var resultLabel: TextField!
    @IBOutlet weak var dateLabel: TextField!
    
    private func commonInit() {
        guard let data = data else { return }

        firstPlayerName.text = data.firstPlayer
        secondPlayerName.text = data.secondPlayer

        firstPlayerDeck.text = data.firstPlayerDeck
        secondPlayerDeck.text = data.secondPlayerDeck

        resultLabel.text = data.result
        dateLabel.text = data.date

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        
        print([data])

    }

}
