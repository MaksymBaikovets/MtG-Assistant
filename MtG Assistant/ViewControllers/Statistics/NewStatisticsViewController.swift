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
    
    // -------------------------------------------------------------------
    // MARK: New Statistics Scene: Outlets
    // -------------------------------------------------------------------

    @IBOutlet var firstPlayerInput: UITextField!
    @IBOutlet var secondPlayerInput: UITextField!

    @IBOutlet var firstPlayerDeck: UITextField!
    @IBOutlet var secondPlayerDeck: UITextField!

    @IBOutlet var gameResultInput: UITextField!
    @IBOutlet var gameDateInput: UITextField!

    @IBOutlet weak var saveNavButton: UINavigationItem!
    
    var statistics: StatisticsHeadline?
    
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

        if identifier == "SaveStatistics" {
            // TODO: Check fields for correctness
            if false {
                let alertController = UIAlertController(
                    title: "Alert",
                    message: "Input value",
                    preferredStyle: .alert
                )
                
                alertController.addAction(UIAlertAction(
                    title: NSLocalizedString("Done", comment: ""),
                    style: .default,
                    handler: nil))

                present(alertController, animated: true, completion: nil)
                return false
            }
        }

        guard let firstPlayerName = firstPlayerInput.text else { return false }
        guard let secondPlayerName = secondPlayerInput.text else { return false }

        guard let firstDeck = firstPlayerDeck.text else { return false }
        guard let secondDeck = secondPlayerDeck.text else { return false }

        guard let result = gameResultInput.text else { return false }
        guard let date = gameDateInput.text else { return false }

        let competitors = firstPlayerName + " / " + secondPlayerName

        self.save(competitors: competitors, firstDeck: firstDeck, secondDeck: secondDeck,
                  result: result, date: date)

        statistics = StatisticsHeadline(competitors: competitors, date: date, result: result,
                                       firstPlayerDeck: firstDeck, secondPlayerDeck: secondDeck)
        
        return true
    }
    
    // -------------------------------------------------------------------
    // MARK: - Save to Core Data
    // -------------------------------------------------------------------

    func save(competitors: String,
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
      
        headlineData.setValuesForKeys(["competitors": competitors,
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
