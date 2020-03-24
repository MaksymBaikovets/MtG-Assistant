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

    var statisticsDataSource = StatisticsDataSource()
    var coreHeadlines: [NSManagedObject] = []
    var data: StatisticsHeadline?
    
    // -------------------------------------------------------------------
    // MARK: Outlets
    // -------------------------------------------------------------------
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
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
        resultLabel.textColor = UIColor.systemGray
        
        dateLabel.text = data.date
        dateLabel.textColor = UIColor.systemGray

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()

        cancelButton.title = NSLocalizedString("Cancel", comment: "")
        saveButton.title = NSLocalizedString("Save", comment: "")
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String,
                                     sender: Any?) -> Bool {
        print([identifier])
        
        guard let firstPlayerLabel = firstPlayerName.text else { return false }
        guard let secondPlayerLabel = secondPlayerName.text else { return false }

        guard let firstDeck = firstPlayerDeck.text else { return false }
        guard let secondDeck = secondPlayerDeck.text else { return false }

        guard let result = resultLabel.text else { return false }
        guard let date = dateLabel.text else { return false }

        if identifier == "SaveUpdatedStatistics" {
            
            // TODO: Check fields for correctness and show errors on form
            while true {
                var alertTitle = String()
                var alertMessage = String()
                
                if firstPlayerLabel == "" {
                    alertTitle = "Field Missing"
                    alertMessage = "Enter First Player name!"
                }
                
                else if secondPlayerLabel == "" {
                    alertTitle = "Field Missing"
                    alertMessage = "Enter Second Player name!"
                }
                    
                else if firstDeck == "" {
                    alertTitle = "Field Missing"
                    alertMessage = "Enter First Deck name!"
                }
                    
                else if secondDeck == "" {
                    alertTitle = "Field Missing"
                    alertMessage = "Enter Second Deck name!"
                }
                    
                else {
                    break
                }
                    
                let alertController = UIAlertController(
                    title: alertTitle,
                    message: alertMessage,
                    preferredStyle: .alert
                )
                    
                alertController.addAction(UIAlertAction(
                    title: NSLocalizedString("Done", comment: ""),
                    style: .default,
                    handler: nil))

                present(alertController, animated: true, completion: nil)
                return false
                
            }
            
            statisticsDataSource.updateRowInCoreData(firstPlayer: firstPlayerLabel,
                                                     secondPlayer: secondPlayerLabel,
                                                     firstDeck: firstDeck,
                                                     secondDeck: secondDeck,
                                                     gameResult: result, date: date)

            data = StatisticsHeadline(firstPlayer: firstPlayerLabel,
                                      secondPlayer: secondPlayerLabel,
                                      date: date,
                                      result: result,
                                      firstPlayerDeck: firstDeck,
                                      secondPlayerDeck: secondDeck
            )
            
            return true
            
        }
        
        return true
        
    }

}
