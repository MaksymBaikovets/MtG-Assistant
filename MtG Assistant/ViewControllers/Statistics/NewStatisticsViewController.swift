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
    
    var coreHeadlines: [NSManagedObject] = []
    var statistics: StatisticsHeadline?
    
    // -------------------------------------------------------------------
    // MARK: Outlets
    // -------------------------------------------------------------------

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
        
        firstPlayerInput.becomeFirstResponder()
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
                var alertTitle = String()
                var alertMessage = String()
                
                if firstPlayerName == "" {
                    alertTitle = "Field Missing"
                    alertMessage = "Enter First Player name!"
                }
                
                else if secondPlayerName == "" {
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
                    
                else if result == "" {
                    alertTitle = "Field Missing"
                    alertMessage = "Enter Result of the game!"
                }
                    
                else if date == "" {
                    alertTitle = "Field Missing"
                    alertMessage = "Enter date of the game!"
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
            
            self.save(firstPlayer: firstPlayerName,
                      secondPlayer: secondPlayerName,
                      firstDeck: firstDeck,
                      secondDeck: secondDeck,
                      result: result,
                      date: date
            )

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
    
    // -------------------------------------------------------------------
    // MARK: - Save to Core Data
    // -------------------------------------------------------------------

    func save(firstPlayer: String,
              secondPlayer: String,
              firstDeck: String,
              secondDeck: String,
              result: String, date: String) {
      
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else { return }
      
        let managedContext =
            appDelegate.persistentContainer.viewContext
      
        let entity =
            NSEntityDescription.entity(forEntityName: "Headline",
                                       in: managedContext)!
      
        let headlineData = NSManagedObject(entity: entity,
                                           insertInto: managedContext)
      
        headlineData.setValuesForKeys(["firstPlayer": firstPlayer,
                                       "secondPlayer": secondPlayer,
                                       "date": date,
                                       "result": result,
                                       "firstPlayerDeck": firstDeck,
                                       "secondPlayerDeck": secondDeck])
        print(headlineData)
        
        do {
            try managedContext.save()
            coreHeadlines.append(headlineData)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}
