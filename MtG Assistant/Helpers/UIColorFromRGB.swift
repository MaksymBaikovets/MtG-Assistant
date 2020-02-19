//
//  UIColorFromRGB.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 19.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class RGBColor: UIColor {
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
