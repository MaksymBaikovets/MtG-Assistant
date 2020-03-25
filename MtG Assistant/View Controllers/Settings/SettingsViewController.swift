//
//  SettingsViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 19.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit
import SafariServices

class SettingsViewController: UITableViewController {
    
    // -------------------------------------------------------------------
    // MARK: - Outlets
    // -------------------------------------------------------------------
    
    @IBOutlet weak var defaultValuesLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var currentLanguageLabel: UILabel!
    
    @IBOutlet weak var contactsLabel: UILabel!
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var aboutCell: UITableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultValuesLabel.text = NSLocalizedString("Default Values", comment: "")
        languageLabel.text = NSLocalizedString("Language", comment: "")
        
        currentLanguageLabel.text = NSLocalizedString("lang", comment: "")
        currentLanguageLabel.textColor = UIColor.systemGray
        
        contactsLabel.text = NSLocalizedString("Contact Developer", comment: "")
        aboutLabel.text = NSLocalizedString("About", comment: "")

        if self.traitCollection.userInterfaceStyle == .dark {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0x000000)
        } else {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0xF6F5FB)
        }
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.title = NSLocalizedString("Settings", comment: "")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
                
        guard let rowTag = tableView.cellForRow(at: indexPath)?.tag else { return indexPath }
        
        if rowTag == 4 {
            
            let message =
            """
            Developer: Maksym Baikovets
            Kyiv, Ukraine

            App designed for personal use with mind of feature release to AppStore.
            """
            
            let alert = UIAlertController(
                title: NSLocalizedString("About", comment: ""),
                message: message,
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("Wizards Website", comment: ""),
                style: .default,
                handler: { (_: UIAlertAction!) in
                    let url = SFSafariViewController(url: URL(string: "https://magic.wizards.com")!)
                self.present(url, animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("Done", comment: ""),
                style: .default,
                handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        return indexPath
        
    }
    
    // -------------------------------------------------------------------
    // MARK: Header and Footer settings
    // -------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        return nil
    }

    override func tableView(_ tableView: UITableView,
                            viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: tableView.frame.size.width,
                                              height: 30))
        return footerView
    }

    override func tableView(_ tableView: UITableView,
                            heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }

    // -------------------------------------------------------------------
    // MARK: Trait Collection changes
    // -------------------------------------------------------------------

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        if self.traitCollection.userInterfaceStyle == .dark {
            cell.backgroundColor = RGBColor().UIColorFromRGBAlpha(rgbValue: 0x211F25)
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
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
