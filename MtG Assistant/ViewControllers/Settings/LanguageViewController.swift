//
//  LanguageViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 19.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class LanguageViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // define which row selected
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let selectedItem = indexPath.row.description
        
        if Int(selectedItem) == 0 {
            print("EN")
            Language.language = Language.english
        } else if Int(selectedItem) == 1 {
            print("RU")
            Language.language = Language.russian
        } else if Int(selectedItem) == 2 {
            print("UK")
            Language.language = Language.ukrainian
        }
        
        let alert = UIAlertController(
            title: NSLocalizedString("Info", comment: ""),
            message: NSLocalizedString("App need to be reloaded", comment: ""),
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("OK", comment: ""),
            style: .default,
            handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        return indexPath
    }

}
