//
//  PlayersHealthViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 01.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class PlayersHealthViewController: UIViewController {

    var devotionToColorOfFirstPlayer = ""
    var devotionToColorOfSecondPlayer = ""

    var showAlert = false
    var index: Int = 0
    
    let buttonsFeedback = UISelectionFeedbackGenerator()
    
    // -------------------------------------------------------------------
    // MARK: - Outlets
    // -------------------------------------------------------------------
    
    @IBOutlet weak var playersHealthTitle: UINavigationItem!
    
    @IBOutlet weak var increaseFirstStatButton: UIButton!
    @IBOutlet weak var decreaseFirstStatButton: UIButton!
    @IBOutlet var firstPlayerStat: UILabel!
    
    @IBOutlet var firstPlayerTable: UIImageView!
    @IBOutlet var firstPlayerGradient: UIImageView!
    @IBOutlet weak var firstPlayerSettingView: UIView!
    @IBOutlet weak var firstPlayerTableChangeView: UIView!
    
    // --- //
    
    @IBOutlet weak var increaseSecondStatButton: UIButton!
    @IBOutlet weak var decreaseSecondStatButton: UIButton!
    @IBOutlet var secondPlayerStat: UILabel!
    
    @IBOutlet var secondPlayerTable: UIImageView!
    @IBOutlet var secondPlayerGradient: UIImageView!
    
    // -------------------------------------------------------------------
    // MARK: - viewDidLoad / awakeFromNib
    // -------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playersHealthTitle!.title = NSLocalizedString("Players Health", comment: "")
        
        // round things for first player
        increaseFirstStatButton.layer.masksToBounds = true
        increaseFirstStatButton.layer.cornerRadius = increaseFirstStatButton.frame.size.width / 2.0
        decreaseFirstStatButton.layer.masksToBounds = true
        decreaseFirstStatButton.layer.cornerRadius = decreaseFirstStatButton.frame.size.width / 2.0
        
        firstPlayerStat.layer.masksToBounds = true
        firstPlayerStat.layer.cornerRadius = firstPlayerStat.frame.size.width / 2.0
        
        // round things for second player
        increaseSecondStatButton.layer.masksToBounds = true
        increaseSecondStatButton.layer.cornerRadius = increaseSecondStatButton.frame.size.width / 2.0
        decreaseSecondStatButton.layer.masksToBounds = true
        decreaseSecondStatButton.layer.cornerRadius = decreaseSecondStatButton.frame.size.width / 2.0

        secondPlayerStat.layer.masksToBounds = true
        secondPlayerStat.layer.cornerRadius = secondPlayerStat.frame.size.width / 2.0
    
        // Mirroring things for the First Player
        firstPlayerStat.transform = CGAffineTransform(scaleX: -1, y: -1)
        firstPlayerTable.transform = CGAffineTransform(scaleX: -1, y: -1)
        firstPlayerGradient.transform = CGAffineTransform(scaleX: -1, y: -1)
        firstPlayerSettingView.transform = CGAffineTransform(scaleX: -1, y: -1)
        firstPlayerTableChangeView.transform = CGAffineTransform(scaleX: -1, y: -1)
        
        // Set initaial backgrounds

        self.devotionToColorOfFirstPlayer =
            Configuration.value(defaultValue: "white", forKey: "firstPlayerTableColor")
        self.devotionToColorOfSecondPlayer =
            Configuration.value(defaultValue: "blue", forKey: "secondPlayerTableColor")
        
        firstPlayerTable.image = selectBackground(playerDevotion: devotionToColorOfFirstPlayer)
        secondPlayerTable.image = selectBackground(playerDevotion: devotionToColorOfSecondPlayer)
        
        // add gesture recognizers
        gestureRecognizer()
            
    } // end of viewDidLoad()
    
    // -------------------------------------------------------------------

    override  func awakeFromNib() {
        super.awakeFromNib()
        self.title = NSLocalizedString("Players Health", comment: "")
    }
    
    // -------------------------------------------------------------------
    // MARK: - Tables Settings (change table color)
    // -------------------------------------------------------------------

    @IBAction func firstPlayerSetting(_ sender: UIButton) {
        self.index = sender.tag
        if self.index == 1 {
            self.showAlert = true
            chooseTableColor(player: "firstPlayer")
        }
    }

    @IBAction func secondPlayerSetting(_ sender: UIButton) {
        self.index = sender.tag
        if self.index == 2 {
            self.showAlert = true
            chooseTableColor(player: "secondPlayer")
        }
    }

    // -------------------------------------------------------------------

    func chooseTableColor(player: String) {
        var changedDevotion: String = ""

        let optionMenu = UIAlertController(
            title: NSLocalizedString("Table Color", comment: ""),
            message: NSLocalizedString("Choose table color for the player", comment: ""),
            preferredStyle: .alert)

        let whiteAction = UIAlertAction(
            title: NSLocalizedString("White (Plain)", comment: ""),
            style: .default,
            handler: { (_: UIAlertAction!) in changedDevotion = "white"
            self.backgroundChange(player: player, devotion: changedDevotion)
            self.showAlert = false
        })

        let redAction = UIAlertAction(
            title: NSLocalizedString("Red (Mountain)", comment: ""),
            style: .default,
            handler: { (_: UIAlertAction!) in changedDevotion = "red"
            self.backgroundChange(player: player, devotion: changedDevotion)
            self.showAlert = false
        })

        let blackAction = UIAlertAction(
            title: NSLocalizedString("Black (Swamp)", comment: ""),
            style: .default,
            handler: { (_: UIAlertAction!) in changedDevotion = "black"
            self.backgroundChange(player: player, devotion: changedDevotion)
            self.showAlert = false
        })

        let greenAction = UIAlertAction(
            title: NSLocalizedString("Green (Forest)", comment: ""),
            style: .default,
            handler: { (_: UIAlertAction!) in changedDevotion = "green"
            self.backgroundChange(player: player, devotion: changedDevotion)
            self.showAlert = false
        })

        let blueAction = UIAlertAction(
            title: NSLocalizedString("Blue (Island)", comment: ""),
            style: .default, handler: { (_: UIAlertAction!) in changedDevotion = "blue"
            self.backgroundChange(player: player, devotion: changedDevotion)
            self.showAlert = false
        })

        let cancelAction = UIAlertAction(
            title: NSLocalizedString("Cancel", comment: ""),
            style: .cancel
        )

        optionMenu.addAction(whiteAction)
        optionMenu.addAction(redAction)
        optionMenu.addAction(blackAction)
        optionMenu.addAction(greenAction)
        optionMenu.addAction(blueAction)
        optionMenu.addAction(cancelAction)

        if self.showAlert == true {
            present(optionMenu, animated: true, completion: nil)
        }
    }

    // -------------------------------------------------------------------
    // MARK: - Changing Backgrounds (choose random from color backgrounds)
    // -------------------------------------------------------------------

    @IBAction func firstPlayerTableChange(_ sender: UIButton) {
        self.index = sender.tag
        if self.index == 3 {
            self.showAlert = false
            backgroundChange(player: "firstPlayer")
        }
    }

    @IBAction func secondPlayerTableChange(_ sender: UIButton) {
        self.index = sender.tag
        if self.index == 4 {
            self.showAlert = false
            backgroundChange(player: "secondPlayer")
        }
    }

    // -------------------------------------------------------------------

    func backgroundChange(player: String, devotion: String? = "") {
        if player == "firstPlayer" {
            guard let img = firstPlayerTable.image else { return }

            if devotion != "" {
                self.devotionToColorOfFirstPlayer = devotion!
            }

            firstPlayerTable.image = selectBackground(
                current: img,
                playerDevotion: self.devotionToColorOfFirstPlayer
            )
            
        }
        
        else if player == "secondPlayer" {
            guard let img = secondPlayerTable.image else { return }

            if devotion != "" {
                self.devotionToColorOfSecondPlayer = devotion!
            }

            secondPlayerTable.image = selectBackground(
                current: img,
                playerDevotion: self.devotionToColorOfSecondPlayer
            )
            
        }
    }

    // -------------------------------------------------------------------

    func selectBackground(current: UIImage = UIImage(), playerDevotion: String) -> UIImage {
        var newBackground: UIImage = current

        while newBackground == current {
            switch playerDevotion {
            case "white":
                newBackground = Backgrounds().whiteTableBackground()
            case "red":
                newBackground = Backgrounds().redTableBackground()
            case "black":
                newBackground = Backgrounds().blackTableBackground()
            case "green":
                newBackground = Backgrounds().greenTableBackground()
            case "blue":
                newBackground = Backgrounds().blueTableBackground()
            default:
                newBackground = current
            }
        }
        return newBackground
    }

    // -------------------------------------------------------------------
    // MARK: - Health Counters Up and Down
    // -------------------------------------------------------------------
    
    @IBAction func counterUp(_ sender: UIButton) {
        if sender.accessibilityLabel == "increaseSecond" {
            guard let value = Int(secondPlayerStat.text!) else { return }
            if value == 99 {
                return
            }
            secondPlayerStat.text = String(value + 1)

        } else if sender.accessibilityLabel == "increaseFirst" {
            guard let value = Int(firstPlayerStat.text!) else { return }
            if value == 99 {
                return
            }
            firstPlayerStat.text = String(value + 1)
        }
        
        buttonsFeedback.selectionChanged()
    }
    
    @IBAction func counterDown(_ sender: UIButton) {
        if sender.accessibilityLabel == "decreaseSecond" {
            guard let value = Int(secondPlayerStat.text!) else { return }
            if value == -99 {
                return
            }
            secondPlayerStat.text = String(value - 1)

        } else if sender.accessibilityLabel == "decreaseFirst" {
            guard let value = Int(firstPlayerStat.text!) else { return }
            if value == -99 {
                return
            }
            firstPlayerStat.text = String(value - 1)
        }
        
        buttonsFeedback.selectionChanged()
    }
    
    func gestureRecognizer() {
    // MARK: - Gesture Recognizers
        
        for views in [firstPlayerStat, secondPlayerStat] {
            
            guard let gestureTarget = views else {
                return
            }
            
            let singleTapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(PlayersHealthViewController.handleSingleTap(_:))
            )
            singleTapGesture.numberOfTapsRequired = 1
            
            let doubleTapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(PlayersHealthViewController.handleDoubleTap(_:))
            )
            doubleTapGesture.numberOfTapsRequired = 2
            
            gestureTarget.addGestureRecognizer(singleTapGesture)
            gestureTarget.addGestureRecognizer(doubleTapGesture)
            
            singleTapGesture.require(toFail: doubleTapGesture)
        }
    }
    
    func gestureSelection(gesture: String) {
        var currentValue: String
        
        if gesture == "singleTapGesture" {
            currentValue = Configuration.value(defaultValue: "counters40", forKey: gesture)
        } else {
            currentValue = Configuration.value(defaultValue: "counters20", forKey: gesture)
        }
        
        
        switch currentValue {
        case "counters20":
            firstPlayerStat.text = "20"
            secondPlayerStat.text = "20"
        case "counters40":
            firstPlayerStat.text = "40"
            secondPlayerStat.text = "40"
        case "countersCustom":
            // create the alert controller
            let alert = UIAlertController(title: "Set your value", message: "Enter a value for counters", preferredStyle: .alert)

            // add the text field. You can configure it however you need
            alert.addTextField { (textField) in
                textField.text = "20"
            }

            // grab the value from the text field, and print it when the user clicks OK
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                print("Text field: \(String(describing: textField!.text))")
                self.firstPlayerStat.text = textField!.text
                self.secondPlayerStat.text = textField!.text
            }))

            // present the alert
            self.present(alert, animated: true, completion: nil)
            
        case "countersSave":
            firstPlayerStat.text = "4"
            secondPlayerStat.text = "4"
        case "countersNone":
            return
        default:
            return
        }
        
        buttonsFeedback.selectionChanged()

    }
    
}

    // -------------------------------------------------------------------
    // MARK: - Gestures Actions
    // -------------------------------------------------------------------

extension PlayersHealthViewController: UIGestureRecognizerDelegate {
    
    @objc func handleSingleTap(_ gesture: UITapGestureRecognizer){
        gestureSelection(gesture: "singleTapGesture")
    }
    
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer){
        gestureSelection(gesture: "doubleTapGesture")
    }
    
}
