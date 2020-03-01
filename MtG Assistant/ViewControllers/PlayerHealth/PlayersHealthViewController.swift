//
//  PlayersHealthViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 01.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class PlayersHealthViewController: UIViewController {
    
    // -------------------------------------------------------------------
    // MARK: Global variables:
    // -------------------------------------------------------------------

    struct GlobalVariables {
        static var devotionToColorOfFirstPlayer = ""
        static var devotionToColorOfSecondPlayer = ""

        static var showAlert = false
        static var index: Int = 0
    }
    
    let notification = UINotificationFeedbackGenerator()
    let buttonsFeedback = UISelectionFeedbackGenerator()
    
    // -------------------------------------------------------------------
    // MARK: Player Health Scene: Outlets
    // -------------------------------------------------------------------

    @IBOutlet var firstPlayerStat: UILabel!
    @IBOutlet var firstPlayerTable: UIImageView!
    @IBOutlet var firstPlayerGradient: UIImageView!
    @IBOutlet weak var firstPlayerCounterView: UIView!
    @IBOutlet weak var firstPlayerSettingView: UIView!
    @IBOutlet weak var firstPlayerTableChangeView: UIView!
    @IBOutlet weak var firstPlayerCounterValue: UIStepper!
    
    @IBOutlet var secondPlayerStat: UILabel!
    @IBOutlet var secondPlayerTable: UIImageView!
    @IBOutlet var secondPlayerGradient: UIImageView!
    @IBOutlet weak var secondPlayerCounterValue: UIStepper!
    
    // -------------------------------------------------------------------
    // MARK: - viewDidLoad / awakeFromNib
    // -------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstPlayerStat.layer.masksToBounds = true
        firstPlayerStat.layer.cornerRadius = firstPlayerStat.frame.size.width / 2.0

        secondPlayerStat.layer.masksToBounds = true
        secondPlayerStat.layer.cornerRadius = secondPlayerStat.frame.size.width / 2.0
    
        // Mirroring things for the First Player
        firstPlayerStat.transform = CGAffineTransform(scaleX: -1, y: -1)
        firstPlayerTable.transform = CGAffineTransform(scaleX: -1, y: -1)
        firstPlayerGradient.transform = CGAffineTransform(scaleX: -1, y: -1)
        firstPlayerSettingView.transform = CGAffineTransform(scaleX: -1, y: -1)
        firstPlayerTableChangeView.transform = CGAffineTransform(scaleX: -1, y: -1)
        firstPlayerCounterView.transform = CGAffineTransform(scaleX: -1, y: -1)
        
        // Set initaial backgrounds
        firstPlayerTable.image = Backgrounds().greenTableBackground()
        GlobalVariables.devotionToColorOfFirstPlayer = "green"
        secondPlayerTable.image = Backgrounds().redTableBackground()
        GlobalVariables.devotionToColorOfSecondPlayer = "red"
        
    // -------------------------------------------------------------------
    // MARK: - Gesture Recognizers
    // -------------------------------------------------------------------
        
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
        GlobalVariables.index = sender.tag
        if GlobalVariables.index == 1 {
            GlobalVariables.showAlert = true
            chooseTableColor(player: "firstPlayer")
        }
    }

    @IBAction func secondPlayerSetting(_ sender: UIButton) {
        GlobalVariables.index = sender.tag
        if GlobalVariables.index == 2 {
            GlobalVariables.showAlert = true
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
            GlobalVariables.showAlert = false
        })

        let redAction = UIAlertAction(
            title: NSLocalizedString("Red (Mountain)", comment: ""),
            style: .default,
            handler: { (_: UIAlertAction!) in changedDevotion = "red"
            self.backgroundChange(player: player, devotion: changedDevotion)
            GlobalVariables.showAlert = false
        })

        let blackAction = UIAlertAction(
            title: NSLocalizedString("Black (Swamp)", comment: ""),
            style: .default,
            handler: { (_: UIAlertAction!) in changedDevotion = "black"
            self.backgroundChange(player: player, devotion: changedDevotion)
            GlobalVariables.showAlert = false
        })

        let greenAction = UIAlertAction(
            title: NSLocalizedString("Green (Forest)", comment: ""),
            style: .default,
            handler: { (_: UIAlertAction!) in changedDevotion = "green"
            self.backgroundChange(player: player, devotion: changedDevotion)
            GlobalVariables.showAlert = false
        })

        let blueAction = UIAlertAction(
            title: NSLocalizedString("Blue (Island)", comment: ""),
            style: .default, handler: { (_: UIAlertAction!) in changedDevotion = "blue"
            self.backgroundChange(player: player, devotion: changedDevotion)
            GlobalVariables.showAlert = false
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

        if GlobalVariables.showAlert == true {
            present(optionMenu, animated: true, completion: nil)
        }
    }

    // -------------------------------------------------------------------
    // MARK: - Changing Backgrounds (choose random from color backgrounds)
    // -------------------------------------------------------------------

    @IBAction func firstPlayerTableChange(_ sender: UIButton) {
        GlobalVariables.index = sender.tag
        if GlobalVariables.index == 3 {
            GlobalVariables.showAlert = false
            backgroundChange(player: "firstPlayer")
        }
    }

    @IBAction func secondPlayerTableChange(_ sender: UIButton) {
        GlobalVariables.index = sender.tag
        if GlobalVariables.index == 4 {
            GlobalVariables.showAlert = false
            backgroundChange(player: "secondPlayer")
        }
    }

    // -------------------------------------------------------------------

    func backgroundChange(player: String, devotion: String? = "") {
        if player == "firstPlayer" {
            guard let img = firstPlayerTable.image else { return }

            if devotion != "" {
                GlobalVariables.devotionToColorOfFirstPlayer = devotion!
            }

            firstPlayerTable.image = selectBackground(
                current: img,
                playerDevotion: GlobalVariables.devotionToColorOfFirstPlayer
            )
            
        }
        
        else if player == "secondPlayer" {
            guard let img = secondPlayerTable.image else { return }

            if devotion != "" {
                GlobalVariables.devotionToColorOfSecondPlayer = devotion!
            }

            secondPlayerTable.image = selectBackground(
                current: img,
                playerDevotion: GlobalVariables.devotionToColorOfSecondPlayer
            )
            
        }
    }

    // -------------------------------------------------------------------

    func selectBackground(current: UIImage, playerDevotion: String) -> UIImage {
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
    // MARK: - Health Counters Initial Values
    // -------------------------------------------------------------------

    @IBAction func firstPlayerCounter(_ sender: UIStepper) {
        firstPlayerStat.text = Int(sender.value).description
        buttonsFeedback.selectionChanged()
    }
    
    @IBAction func secondPlayerCounter(_ sender: UIStepper) {
        secondPlayerStat.text = Int(sender.value).description
        buttonsFeedback.selectionChanged()
    }
    
}

    // -------------------------------------------------------------------
    // MARK: - Gestures Actions
    // -------------------------------------------------------------------

extension PlayersHealthViewController: UIGestureRecognizerDelegate {
    
    @objc func handleSingleTap(_ gesture: UITapGestureRecognizer){
        firstPlayerStat.text = "30"
        secondPlayerStat.text = "30"
        
        self.firstPlayerCounterValue.value = 30
        self.secondPlayerCounterValue.value = 30
        
        notification.notificationOccurred(.warning)
    }
    
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer){
        firstPlayerStat.text = "20"
        secondPlayerStat.text = "20"
        
        self.firstPlayerCounterValue.value = 20
        self.secondPlayerCounterValue.value = 20
        
        notification.notificationOccurred(.success)
    }
    
}
