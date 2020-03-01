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

    @IBOutlet weak var aboutCell: UITableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.traitCollection.userInterfaceStyle == .dark {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0x000000)
        }
        
        else {
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
    // MARK: - Table view data source (NOT IMLEMENTED)
    // -------------------------------------------------------------------

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView,
//                            numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    
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
