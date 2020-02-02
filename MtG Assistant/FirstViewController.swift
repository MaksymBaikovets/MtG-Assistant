//
//  FirstViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 01.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    // MARK: Global variables:
    struct GlobalVariables {
        static var devotionToColorOfFirstPlayer = ""
        static var devotionToColorOfSecondPlayer = ""
        static var showAlert = false
        static var index: Int = 0
    }
    
    // MARK: Main.storyboard Outlets
    @IBOutlet weak var firstStatBackground: UIImageView!
    @IBOutlet weak var firstPlayerStat: UILabel!
    @IBOutlet weak var firstPlayerTable: UIImageView!
    @IBOutlet weak var firstPlayerGradient: UIImageView!
    
    @IBOutlet weak var secondStatBackground: UIImageView!
    @IBOutlet weak var secondPlayerStat: UILabel!
    @IBOutlet weak var secondPlayerTable: UIImageView!
    @IBOutlet weak var secondPlayerGradient: UIImageView!
    
    // MARK: Tables Settings
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
                    
        let whiteAction = UIAlertAction(title: "White (Plain)", style: .default, handler: { (action: UIAlertAction!) in
            changedDevotion = "white"
            self.backgroundChange(player: player, devotion: changedDevotion)
            GlobalVariables.showAlert = false
        })
        let redAction = UIAlertAction(title: "Red (Mountain)", style: .default, handler: { (action: UIAlertAction!) in
            changedDevotion = "red"
            self.backgroundChange(player: player, devotion: changedDevotion)
            GlobalVariables.showAlert = false
        })
        let blackAction = UIAlertAction(title: "Black (Swamp)", style: .default, handler: { (action: UIAlertAction!) in
            changedDevotion = "black"
            self.backgroundChange(player: player, devotion: changedDevotion)
            GlobalVariables.showAlert = false
        })
        let greenAction = UIAlertAction(title: "Green (Forest)", style: .default, handler: { (action: UIAlertAction!) in
            changedDevotion = "green"
            self.backgroundChange(player: player, devotion: changedDevotion)
            GlobalVariables.showAlert = false
        })
        let blueAction = UIAlertAction(title: "Blue (Island)", style: .default, handler: { (action: UIAlertAction!) in
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
            self.present(optionMenu, animated: true, completion: nil)
        }
        
    }
    
    // MARK: Changing Backgrounds for tables:
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
        }
        
        else if player == "secondPlayer" {
            guard let img = secondPlayerTable.image else { return }

            if devotion != "" {
                GlobalVariables.devotionToColorOfSecondPlayer = devotion!
            }

            secondPlayerTable.image = selectBackground(current: img, playerDevotion: GlobalVariables.devotionToColorOfSecondPlayer)
        }
    }
    
    func selectBackground(current: UIImage, playerDevotion: String) -> UIImage {
        var newBackground: UIImage = current
        
        while (newBackground == current) {
            switch playerDevotion {
            case "white":
                newBackground = TableViewController().whiteTableBackground()
            case "red":
                newBackground = TableViewController().redTableBackground()
            case "black":
                newBackground = TableViewController().blackTableBackground()
            case "green":
                newBackground = TableViewController().greenTableBackground()
            case "blue":
                newBackground = TableViewController().blueTableBackground()
            default:
                newBackground = current
            }
        }
        return newBackground
    }
    
    // MARK: Init Health Counters
    @IBAction func firstPlayerCounter(_ sender: UIStepper) {
        firstPlayerStat.text = Int(sender.value).description
    }
    
    @IBAction func secondPlayerCounter(_ sender: UIStepper) {
        secondPlayerStat.text = Int(sender.value).description
    }

    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        firstStatBackground.layer.cornerRadius = firstStatBackground.frame.size.width / 2.0
        secondStatBackground.layer.cornerRadius = secondStatBackground.frame.size.width / 2.0

        // Mirroring things for the First Player
        self.firstPlayerStat.transform = CGAffineTransform(scaleX: -1, y: -1);
        self.firstPlayerTable.transform = CGAffineTransform(scaleX: -1, y: -1);
        self.firstPlayerGradient.transform = CGAffineTransform(scaleX: -1, y: -1);

        firstPlayerTable.image = TableViewController().greenTableBackground()
            GlobalVariables.devotionToColorOfFirstPlayer = "green"
        secondPlayerTable.image = TableViewController().redTableBackground()
            GlobalVariables.devotionToColorOfSecondPlayer = "red"

    }

}



// MARK: Backgrounds arrays:
class TableViewController {
    
    func whiteTableBackground() -> UIImage {
        let whiteBackgrounds = [#imageLiteral(resourceName: "1stWhite"), #imageLiteral(resourceName: "2ndWhite"), #imageLiteral(resourceName: "3rdWhite"), #imageLiteral(resourceName: "4thWhite"), #imageLiteral(resourceName: "5thWhite")]
        return whiteBackgrounds[Int(arc4random_uniform(UInt32(whiteBackgrounds.count)))]
    }
    
    func redTableBackground() -> UIImage {
        let redBackgrounds = [#imageLiteral(resourceName: "1stRed"), #imageLiteral(resourceName: "2ndRed"), #imageLiteral(resourceName: "3rdRed"), #imageLiteral(resourceName: "4thRed"), #imageLiteral(resourceName: "5thRed"), #imageLiteral(resourceName: "6thRed"), #imageLiteral(resourceName: "7thRed")]
        return redBackgrounds[Int(arc4random_uniform(UInt32(redBackgrounds.count)))]
    }
    
    func blackTableBackground() -> UIImage {
        let blackBackgrounds = [#imageLiteral(resourceName: "1stBlack"), #imageLiteral(resourceName: "2ndBlack"), #imageLiteral(resourceName: "3rdBlack"), #imageLiteral(resourceName: "4thBlack"), #imageLiteral(resourceName: "5thBlack")]
        return blackBackgrounds[Int(arc4random_uniform(UInt32(blackBackgrounds.count)))]
    }
    
    func greenTableBackground() -> UIImage {
        let greenBackgrounds = [#imageLiteral(resourceName: "1stGreen"), #imageLiteral(resourceName: "2ndGreen"), #imageLiteral(resourceName: "3rdGreen"), #imageLiteral(resourceName: "4thGreen"), #imageLiteral(resourceName: "5thGreen"), #imageLiteral(resourceName: "6thGreen"), #imageLiteral(resourceName: "7thGreen"), #imageLiteral(resourceName: "8thGreen")]
        return greenBackgrounds[Int(arc4random_uniform(UInt32(greenBackgrounds.count)))]
    }
    
    func blueTableBackground() -> UIImage {
        let blueBackgrounds = [#imageLiteral(resourceName: "1stBlue"), #imageLiteral(resourceName: "2ndBlue"), #imageLiteral(resourceName: "3rdBlue"), #imageLiteral(resourceName: "4thBlue"), #imageLiteral(resourceName: "5thBlue")]
        return blueBackgrounds[Int(arc4random_uniform(UInt32(blueBackgrounds.count)))]
    }
    
}



