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
    
    // -------------------------------------------------------------------
    // MARK: - Outlets
    // -------------------------------------------------------------------
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardType: UILabel!
    
    @IBOutlet weak var oracleTextTitle: UILabel!
    @IBOutlet weak var oracleText: UILabel!
    
    @IBOutlet weak var flavorTextTitle: UILabel!
    @IBOutlet weak var flavorText: UILabel!
    
    @IBOutlet weak var cardImage: UIImageView!
    
    // -------------------------------------------------------------------
    // MARK: - Init VC
    // -------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    private func commonInit() {
        guard let data = data else { return }

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
                self.oracleText.text = data.oracleText
            }
            
            if data.flavorText == nil {
                self.flavorTextTitle.isHidden = true
                self.flavorText.isHidden = true
                self.cardImage.topAnchor
                    .constraint(equalTo: self.oracleText.bottomAnchor, constant: 16)
                    .isActive = true
            } else {
                self.flavorText.text = data.flavorText
            }
        }
        
    }

    // -------------------------------------------------------------------
    // MARK: - Alamofire
    // -------------------------------------------------------------------
    
    func cardImageLoad() {
        guard let data = data else { return }
        
        // images variants
//        guard let urlPng = data.imageUris?.png else { return }
//        guard let urlLarge = data.imageUris?.large else { return }
        
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

}
