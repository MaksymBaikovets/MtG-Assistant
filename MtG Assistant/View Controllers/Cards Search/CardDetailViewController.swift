//
//  CardDetailViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 01.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit
import Alamofire

class CardDetailViewController: UIViewController {

    var data: CardDisplayable?
    var listData: [CardDisplayable] = []
    
    var cardId: String?
    var rules: [Rule] = []
    
    // -------------------------------------------------------------------
    // MARK: - Outlets
    // -------------------------------------------------------------------
    
    @IBOutlet weak var cardImage: UIImageView!
    
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardType: UILabel!
    
    @IBOutlet weak var oracleTextTitle: UILabel!
    @IBOutlet weak var oracleText: UILabel!
    
    @IBOutlet weak var flavorTextTitle: UILabel!
    @IBOutlet weak var flavorText: UILabel!
    
    @IBOutlet weak var cardRulingsTitle: UILabel!
    @IBOutlet weak var cardRulingsText: UILabel!
        
    // -------------------------------------------------------------------
    // MARK: - Init VC
    // -------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        
        if self.traitCollection.userInterfaceStyle == .dark {
            oracleText.textColor = UIColor.white
            flavorText.textColor = UIColor.white
        } else {
            oracleText.textColor = UIColor.black
            flavorText.textColor = UIColor.black
        }
        
    }
    
    private func commonInit() {
        guard let data = data else { return }
        self.cardId = data.id
        
        cardRulingsLoad()
        cardImageLoad()
        
        self.cardImage.layer.borderWidth = 2
        self.cardImage.layer.borderColor = UIColor.white.cgColor

        DispatchQueue.main.async {
            self.cardName.text = data.name
            self.cardType.text = data.typeLine
            
            if data.oracleText == nil {
                self.oracleTextTitle.isHidden = true
                self.oracleText.isHidden = true
            } else {
                let oracleAttributed = NSMutableAttributedString(string: data.oracleText!)
                self.oracleText.attributedText = oracleAttributed
            }

            if data.flavorText == nil {
                self.flavorTextTitle.isHidden = true
                self.flavorText.isHidden = true
                self.cardRulingsTitle.topAnchor
                    .constraint(equalTo: self.oracleText.bottomAnchor, constant: 16)
                    .isActive = true
            } else {
                let flavorAttributed = NSMutableAttributedString(string: data.flavorText!)
                self.flavorText.attributedText = flavorAttributed
            }
            
        }
        
    }

    // -------------------------------------------------------------------
    // MARK: - Alamofire
    // -------------------------------------------------------------------
    
    func cardImageLoad() {
        guard let data = data else { return }
        
        // images variants
//        guard let urlPng = data.imageUris?.png else
//        guard let urlLarge = data.imageUris?.large else
        
        guard let urlBorderCropped = data.imageUris?.borderCrop else {
            self.cardImage.image = #imageLiteral(resourceName: "cardBack")
            return
        }
        
        AF.request(urlBorderCropped, method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
                self.cardImage.image = UIImage(data: responseData.data!)
                
            })
    }
    
    func cardRulingsLoad() {
        guard let cardId = cardId else { return }
        
        let url = "https://api.scryfall.com/cards/" + cardId + "/rulings"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: CardRulings.self) {
                (response) in guard let rulings = response.value else { return }
                                
                if rulings.data.count == 0 { return }
                else {
                    self.cardRulingsText.isHidden = false
                    self.cardRulingsTitle.isHidden = false
                    self.rules = rulings.data
                }
                
                var allRules: String = ""
                
                for rule in 0...self.rules.endIndex {
                    if rule == self.rules.endIndex { break }
                    allRules += String(rule + 1) + ". " + self.rules[rule].comment + "\n\n"
                }
                
                let rulesAttributed = NSMutableAttributedString(string: allRules)
                self.cardRulingsText.attributedText = rulesAttributed
        }
        
    }
    
    
    // -------------------------------------------------------------------
    // MARK: Trait Collection changes
    // -------------------------------------------------------------------
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.userInterfaceStyle == .dark {
            oracleText.textColor = UIColor.white
            flavorText.textColor = UIColor.white
        } else {
            oracleText.textColor = UIColor.black
            flavorText.textColor = UIColor.black
        }
        
    }

}

