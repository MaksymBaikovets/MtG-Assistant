//
//  NewStatisticsViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 05.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class NewStatisticsViewController: UITableViewController, UITextFieldDelegate {
    
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
        
        firstPlayerInput.becomeFirstResponder()
    }

    // MARK: - Navigation
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
    
//    MARK: Errors handling (NOT IMPLEMENTED)
    
//    var validForm: Bool = false
//    @IBAction func doneButtonPress(_ sender: UIBarButtonItem) {
//        guard let firstPlayerName = firstPlayerInput.text else {
//            firstPlayerInput.attributedPlaceholder = NSAttributedString(string: "Please enter Your Email ID", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
//            validForm = false
//            return
//        }
//    }
    
//  MARK: - Segues
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
