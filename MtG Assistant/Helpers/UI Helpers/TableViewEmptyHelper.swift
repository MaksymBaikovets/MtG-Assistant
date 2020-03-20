//
//  TableViewEmptyHelper.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 02.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        messageLabel.text = message
        
        if self.traitCollection.userInterfaceStyle == .dark {
            messageLabel.textColor = .white
        }
        
        else {
            messageLabel.textColor = .black
        }
        
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        messageLabel.sizeToFit()
        
        // TODO: Need to show icon with text
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
//        imageView.image = #imageLiteral(resourceName: "statisticsPlaceholder")

        self.backgroundView = messageLabel
        self.separatorStyle = .none
        self.isScrollEnabled = false
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
        self.isScrollEnabled = true

    }
    
}
