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

    var statistics: StatisticsHeadline?
    
    // -------------------------------------------------------------------
    // MARK: viewDidLoad
    // -------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstPlayerInput.becomeFirstResponder()
    }
    
    // -------------------------------------------------------------------
    // MARK: - Keyboard Navigation (NOT USED)
    // -------------------------------------------------------------------
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
    
    // -------------------------------------------------------------------
    //  MARK: Errors handling (NOT IMPLEMENTED)
    // -------------------------------------------------------------------

//    var validForm: Bool = false
//    @IBAction func doneButtonPress(_ sender: UIBarButtonItem) {
//        guard let firstPlayerName = firstPlayerInput.text else {
//            firstPlayerInput.attributedPlaceholder = NSAttributedString(string: "Please enter Your Email ID", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
//            validForm = false
//            return
//        }
//    }
    
    // -------------------------------------------------------------------
    //  MARK: Segues
    // -------------------------------------------------------------------

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "SaveStatistics" {
            guard let firstPlayerName = firstPlayerInput.text else { return }
            guard let secondPlayerName = secondPlayerInput.text else { return }

            guard let firstDeck = firstPlayerDeck.text else { return }
            guard let secondDeck = secondPlayerDeck.text else { return }

            guard let result = gameResultInput.text else { return }
            guard let date = gameDateInput.text else { return }
            
            let competitors = firstPlayerName + " / " + secondPlayerName
            
            self.save(competitors: competitors, firstDeck: firstDeck, secondDeck: secondDeck,
                      result: result, date: date)
            
            statistics = StatisticsHeadline(competitors: competitors, date: date, result: result,
                                           firstPlayerDeck: firstDeck, secondPlayerDeck: secondDeck)

        }
    }
    
    // MARK: - Save to Core Data
    func save(competitors: String, firstDeck: String, secondDeck: String,
              result: String, date: String) {
      
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
      
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
      
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Headline",
                                   in: managedContext)!
      
        let headlineData = NSManagedObject(entity: entity,
                                           insertInto: managedContext)
      
        // 3
//      headlineData.setValue(firstPlayerName, forKeyPath: "name")
        headlineData.setValuesForKeys(["competitors": competitors, "date": date, "result": result,
                                        "firstPlayerDeck": firstDeck, "secondPlayerDeck": secondDeck])
        print(headlineData)
        
        // 4
        do {
            try managedContext.save()
            coreHeadlines.append(headlineData)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}
