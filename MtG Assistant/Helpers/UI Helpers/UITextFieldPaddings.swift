//
//  UITextViewPaddings.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 17.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class TextField: UITextField {

    let padding = UIEdgeInsets(
        top: 0,
        left: 10,
        bottom: 0,
        right: 5
    )

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
