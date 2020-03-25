//
//  ContactsViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 19.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController {

    // -------------------------------------------------------------------
    // MARK: - Outlets
    // -------------------------------------------------------------------
    
    @IBOutlet weak var ukraineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ukraineLabel.text = NSLocalizedString("Ukraine", comment: "")
        tableView.tableFooterView = UIView()
        
        if self.traitCollection.userInterfaceStyle == .dark {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0x000000)
        } else {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0xF6F5FB)
        }

    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.title = NSLocalizedString("Contact Developer", comment: "")
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
            let botURL = URL.init(string: "https://t.me/\("MtGAssistantBot")")

            if UIApplication.shared.canOpenURL(botURL!) {
                UIApplication.shared.open(botURL!)
            } else {
                let urlAppStore = URL(string: "itms-apps://apps.apple.com/us/app/telegram-messenger/id686449807")
                if(UIApplication.shared.canOpenURL(urlAppStore!))
                {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(urlAppStore!, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(urlAppStore!)
                    }
                    
                }
                
            }
            
        } else if Int(selectedItem) == 1 {
            let email = "mtgassistant.help@gmail.com"
            let url = URL(string: "mailto:\(email)")
            UIApplication.shared.open(url!)
            
        } else if Int(selectedItem) == 2 {
            let number = URL(string: "tel://" + "380508660585")
            UIApplication.shared.open(number!)
                        
        }
        
        return indexPath
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
