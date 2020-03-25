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
        
        commonInit()
        
        if self.traitCollection.userInterfaceStyle == .dark {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0x000000)
        } else {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0xF6F5FB)
        }
        
    }
    
    func commonInit() {
        let lang = Configuration.value(defaultValue: "", forKey: "appLanguage")

        switch lang {
        case "en":
            tableView.cellForRow(at: [0, 0])?.accessoryType = UITableViewCell.AccessoryType.checkmark
        case "ru":
            tableView.cellForRow(at: [0, 1])?.accessoryType = UITableViewCell.AccessoryType.checkmark
        case "uk":
            tableView.cellForRow(at: [0, 2])?.accessoryType = UITableViewCell.AccessoryType.checkmark
        default:
            break
        }
        
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.title = NSLocalizedString("Language", comment: "")
    }
    
    // -------------------------------------------------------------------
    // MARK: - Table view data source
    // -------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // define which row selected
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        let selectedItem = indexPath.row.description
        
        if Int(selectedItem) == 0 {
            Language.language = Language.english
        } else if Int(selectedItem) == 1 {
            Language.language = Language.russian
        } else if Int(selectedItem) == 2 {
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

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        
        if self.traitCollection.userInterfaceStyle == .dark {
            cell.backgroundColor = RGBColor().UIColorFromRGBAlpha(rgbValue: 0x211F25)
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    // -------------------------------------------------------------------
    // MARK: Trait Collection changes
    // -------------------------------------------------------------------
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.userInterfaceStyle == .dark {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0x000000)
            tableView.reloadData()
        } else {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0xF6F5FB)
            tableView.reloadData()
        }
    }

}
