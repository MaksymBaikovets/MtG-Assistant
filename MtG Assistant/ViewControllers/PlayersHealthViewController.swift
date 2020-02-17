//
//  FirstViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 01.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class PlayersHealthViewController: UIViewController {
    // MARK: Global variables:

    struct GlobalVariables {
        static var devotionToColorOfFirstPlayer = ""
        static var devotionToColorOfSecondPlayer = ""

        static var showAlert = false
        static var index: Int = 0
    }

    // MARK: Player Health Scene: Outlets

    @IBOutlet var firstPlayerStat: UILabel!
    @IBOutlet var secondPlayerStat: UILabel!

    @IBOutlet var firstPlayerTable: UIImageView!
    @IBOutlet var secondPlayerTable: UIImageView!

    @IBOutlet var firstPlayerGradient: UIImageView!
    @IBOutlet var secondPlayerGradient: UIImageView!

    // MARK: Tables Settings

    @IBOutlet weak var firstPlayerSettingView: UIView!
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

    func chooseTableColor(player: String) {
        var changedDevotion: String = ""

        let optionMenu = UIAlertController(title: "Table Color", message: "Choose the one for the player", preferredStyle: .alert)

        let whiteAction = UIAlertAction(title: "White (Plain)", style: .default, handler: { (_: UIAlertAction!) in
            changedDevotion = "white"
            self.backgroundChange(player: player, devotion: changedDevotion)
            GlobalVariables.showAlert = false
        })

        let redAction = UIAlertAction(title: "Red (Mountain)", style: .default, handler: { (_: UIAlertAction!) in
            changedDevotion = "red"
            self.backgroundChange(player: player, devotion: changedDevotion)
            GlobalVariables.showAlert = false
        })

        let blackAction = UIAlertAction(title: "Black (Swamp)", style: .default, handler: { (_: UIAlertAction!) in
            changedDevotion = "black"
            self.backgroundChange(player: player, devotion: changedDevotion)
            GlobalVariables.showAlert = false
        })

        let greenAction = UIAlertAction(title: "Green (Forest)", style: .default, handler: { (_: UIAlertAction!) in
            changedDevotion = "green"
            self.backgroundChange(player: player, devotion: changedDevotion)
            GlobalVariables.showAlert = false
        })

        let blueAction = UIAlertAction(title: "Blue (Island)", style: .default, handler: { (_: UIAlertAction!) in
            changedDevotion = "blue"
            self.backgroundChange(player: player, devotion: changedDevotion)
            GlobalVariables.showAlert = false
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

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

    // MARK: Changing Backgrounds for tables:

    @IBOutlet weak var firstPlayerTableChangeView: UIView!
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

    func backgroundChange(player: String, devotion: String? = "") {
        if player == "firstPlayer" {
            guard let img = firstPlayerTable.image else { return }

            if devotion != "" {
                GlobalVariables.devotionToColorOfFirstPlayer = devotion!
            }

            firstPlayerTable.image = selectBackground(current: img, playerDevotion: GlobalVariables.devotionToColorOfFirstPlayer)
        } else if player == "secondPlayer" {
            guard let img = secondPlayerTable.image else { return }

            if devotion != "" {
                GlobalVariables.devotionToColorOfSecondPlayer = devotion!
            }

            secondPlayerTable.image = selectBackground(current: img, playerDevotion: GlobalVariables.devotionToColorOfSecondPlayer)
        }
    }

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

    // MARK: Init Health Counters

    @IBOutlet weak var firstPlayerCounterView: UIView!
    @IBAction func firstPlayerCounter(_ sender: UIStepper) {
        firstPlayerStat.text = Int(sender.value).description
    }

    @IBAction func secondPlayerCounter(_ sender: UIStepper) {
        secondPlayerStat.text = Int(sender.value).description
    }

    // MARK: viewDidLoad

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
        
        
        firstPlayerTable.image = Backgrounds().greenTableBackground()
        GlobalVariables.devotionToColorOfFirstPlayer = "green"
        secondPlayerTable.image = Backgrounds().redTableBackground()
        GlobalVariables.devotionToColorOfSecondPlayer = "red"
    }
}

extension UIView {
    func rotate(degrees: CGFloat) {
        rotate(radians: CGFloat.pi * degrees / 180.0)
    }

    func rotate(radians: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
}
