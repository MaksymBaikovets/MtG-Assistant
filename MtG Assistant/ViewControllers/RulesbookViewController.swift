//
//  RulesbookViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 16.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class RulesbookViewController: UIViewController {

    @IBOutlet var rulings: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let filePath = Bundle.main.path(
            forResource: "MagicCompRules_20200122", ofType: "txt") else { return }
        
        do {
            let content = try String(contentsOfFile:filePath, encoding: String.Encoding.utf8)
            print(content)
            rulings.text = content
        } catch {
            print("nil")
        }
        
    }

}
