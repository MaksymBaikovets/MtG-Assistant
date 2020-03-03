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

    var data: Displayable?
    var listData: [Displayable] = []
    
    // -------------------------------------------------------------------
    // MARK: Outlets
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
    // MARK: commonInit
    // -------------------------------------------------------------------
    
    private func commonInit() {
        guard let data = data else { return }

        cardImageLoad()

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
            } else {
                self.flavorText.text = data.flavorText
            }
        }
        
    }

    func cardImageLoad() {
        guard let data = data else { return }
//        guard let urlPng = data.imageUris?.png else { return }
//        guard let urlLarge = data.imageUris?.large else { return }
        guard let urlBorderCropped = data.imageUris?.borderCrop else { return }
        
        AF.request(urlBorderCropped, method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
                self.cardImage.image = UIImage(data: responseData.data!)
                
            })
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}
