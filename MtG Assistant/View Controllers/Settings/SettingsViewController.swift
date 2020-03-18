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

    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var currentLanguageLabel: UILabel!
    
    @IBOutlet weak var contactsLabel: UILabel!
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var aboutCell: UITableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        languageLabel.text = NSLocalizedString("Language", comment: "")
        currentLanguageLabel.text = NSLocalizedString("lang", comment: "")
        contactsLabel.text = NSLocalizedString("Contact Developer", comment: "")
        aboutLabel.text = NSLocalizedString("About", comment: "")
        
        editButton?.isEnabled = false
        editButton?.tintColor = UIColor.clear

        if self.traitCollection.userInterfaceStyle == .dark {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0x000000)
        } else {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0xF3F3F3)
        }
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.title = NSLocalizedString("Settings", comment: "")
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let rowTag = tableView.cellForRow(at: indexPath)?.tag else { return }
        
        if rowTag == 5 {
            
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
                                              height: 44))
        return footerView
    }

    override func tableView(_ tableView: UITableView,
                            heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }

    // -------------------------------------------------------------------
    // MARK: Trait Collection changes
    // -------------------------------------------------------------------

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.userInterfaceStyle == .dark {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0x000000)
        } else {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0xF3F3F3)
        }
    }
    
}
