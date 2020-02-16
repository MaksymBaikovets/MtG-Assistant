//
//  NewStatisticsViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 05.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class NewStatisticsViewController: UITableViewController {
    // MARK: New Statistics Scene: Outlets

    @IBOutlet var firstPlayerInput: UITextField!
    @IBOutlet var secondPlayerInput: UITextField!

    @IBOutlet var firstPlayerDeck: UITextField!
    @IBOutlet var secondPlayerDeck: UITextField!

    @IBOutlet var gameResultInput: UITextField!
    @IBOutlet var gameDateInput: UITextField!

    var statistics: StatisticsHeadline?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "SaveStatistics" {
            guard let firstPlayerName = firstPlayerInput.text else { return }
            guard let secondPlayerName = secondPlayerInput.text else { return }

            guard let firstDeck = firstPlayerDeck.text else { return }
            guard let secondDeck = secondPlayerDeck.text else { return }

            guard let result = gameResultInput.text else { return }
            guard let date = gameDateInput.text else { return }

            let competitors = firstPlayerName + " : " + secondPlayerName
            statistics = StatisticsHeadline(competitors: competitors, date: date, result: result,
                                            firstPlayerDeck: firstDeck, secondPlayerDeck: secondDeck)
        }
    }
}
