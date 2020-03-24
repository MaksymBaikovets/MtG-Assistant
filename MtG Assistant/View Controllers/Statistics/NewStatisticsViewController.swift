//
//  NewStatisticsViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 05.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit
import CoreData

class NewStatisticsViewController: UITableViewController, UITextFieldDelegate {
    
    var statisticsDataSource = StatisticsDataSource()
    var coreHeadlines: [NSManagedObject] = []
    var statistics: StatisticsHeadline?
    
    
    // -------------------------------------------------------------------
    // MARK: Outlets
    // -------------------------------------------------------------------
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBOutlet var firstPlayerInput: UITextField!
    @IBOutlet var secondPlayerInput: UITextField!

    @IBOutlet var firstPlayerDeck: UITextField!
    @IBOutlet var secondPlayerDeck: UITextField!

    @IBOutlet var gameResultInput: UITextField!
    @IBOutlet var gameDateInput: UITextField!
    
    // -------------------------------------------------------------------
    // MARK: viewDidLoad
    // -------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButton.title = NSLocalizedString("Cancel", comment: "")
        saveButton.title = NSLocalizedString("Save", comment: "")
        
        datePickerCreate()
        firstPlayerInput.becomeFirstResponder()
        
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.title = NSLocalizedString("Add New Game", comment: "")
    }
    
    func datePickerCreate() {
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.backgroundColor = UIColor.systemBackground
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        gameDateInput.inputView = datePickerView
        
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        gameDateInput.text = dateFormatter.string(from: date)
        
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged),
                                 for: UIControl.Event.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.timeStyle = DateFormatter.Style.none
            gameDateInput.text = dateFormatter.string(from: sender.date)
    }
    
    // -------------------------------------------------------------------
    // MARK: Keyboard Navigation (NOT USED)
    // -------------------------------------------------------------------
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        let nextTag = textField.tag + 1
//
//        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
//            nextResponder.becomeFirstResponder()
//        } else {
//            textField.resignFirstResponder()
//        }
//
//        return true
//    }
    
    // -------------------------------------------------------------------
    //  MARK: - Segues (Error handle in form & Data transfer)
    // -------------------------------------------------------------------
    
    override func shouldPerformSegue(withIdentifier identifier: String,
                                     sender: Any?) -> Bool {
        
        guard let firstPlayerName = firstPlayerInput.text else { return false }
        guard let secondPlayerName = secondPlayerInput.text else { return false }

        guard let firstDeck = firstPlayerDeck.text else { return false }
        guard let secondDeck = secondPlayerDeck.text else { return false }

        guard let result = gameResultInput.text else { return false }
        guard let date = gameDateInput.text else { return false }

        if identifier == "SaveStatistics" {
            
            // TODO: Check fields for correctness and show errors on form
            while true {
                let alertTitle = NSLocalizedString("Field Missing", comment: "")
                var alertMessage = String()
                
                if firstPlayerName == "" {
                    alertMessage = "Enter First Player name"
                }
                
                else if secondPlayerName == "" {
                    alertMessage = "Enter Second Player name"
                }
                    
                else if firstDeck == "" {
                    alertMessage = "Enter First Deck name"
                }
                    
                else if secondDeck == "" {
                    alertMessage = "Enter Second Deck name"
                }
                    
                else if result == "" {
                    alertMessage = "Enter Result of the game"
                }
                    
                else if date == "" {
                    alertMessage = "Enter date of the game"
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
            
            statisticsDataSource.saveToCoreData(firstPlayer: firstPlayerName,
                  secondPlayer: secondPlayerName,
                  firstDeck: firstDeck,
                  secondDeck: secondDeck,
                  result: result, date: date)

            statistics = StatisticsHeadline(firstPlayer: firstPlayerName,
                                            secondPlayer: secondPlayerName,
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
