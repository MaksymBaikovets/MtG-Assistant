//
//  DefaultsViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 19.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class DefaultsViewController: UITableViewController {
    
    var playerSelected: Int?
    
    @IBOutlet weak var firstPlayerColorLabel: UILabel!
    @IBOutlet weak var secondPlayerColorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        firstPlayerColorLabel.text = NSLocalizedString(
            Configuration.value(defaultValue: "white", forKey: "firstPlayerTableColor"), comment: "")
        secondPlayerColorLabel.text = NSLocalizedString(
            Configuration.value(defaultValue: "blue", forKey: "secondPlayerTableColor"), comment: "")
        
        let isGesturesEnabled = Configuration.value(defaultValue: true, forKey: "isGesturesEnabled")
        if isGesturesEnabled == false {
            tableView.cellForRow(at: [1, 0])?.accessoryType = UITableViewCell.AccessoryType.none
            
            tableView.cellForRow(at: [1, 1])!.isUserInteractionEnabled = false
            tableView.cellForRow(at: [1, 1])!.contentView.alpha = 0.5
            
            tableView.cellForRow(at: [1, 2])!.isUserInteractionEnabled = false
            tableView.cellForRow(at: [1, 2])!.contentView.alpha = 0.5
            
        } else {
            tableView.cellForRow(at: [1, 0])?.accessoryType = UITableViewCell.AccessoryType.checkmark
            
            tableView.cellForRow(at: [1, 1])!.isUserInteractionEnabled = true
            tableView.cellForRow(at: [1, 1])!.contentView.alpha = 1
            
            tableView.cellForRow(at: [1, 2])!.isUserInteractionEnabled = true
            tableView.cellForRow(at: [1, 2])!.contentView.alpha = 1
        }
        
        if self.traitCollection.userInterfaceStyle == .dark {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0x000000)
        } else {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0xF6F5FB)
        }

    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.title = NSLocalizedString("Default Values", comment: "")
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
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return indexPath }
    
        if cell.tag == 0 {
            playerSelected = 0
        } else if cell.tag == 1 {
            playerSelected = 1
        } else if cell.tag == 2 {
            
            if cell.accessoryType == UITableViewCell.AccessoryType.checkmark {
                Configuration.value(value: false, forKey: "isGesturesEnabled")
                cell.accessoryType = UITableViewCell.AccessoryType.none
                
                tableView.cellForRow(at: [1, 1])!.isUserInteractionEnabled = false
                tableView.cellForRow(at: [1, 1])!.contentView.alpha = 0.5
                
                tableView.cellForRow(at: [1, 2])!.isUserInteractionEnabled = false
                tableView.cellForRow(at: [1, 2])!.contentView.alpha = 0.5
                
            } else {
                Configuration.value(value: true, forKey: "isGesturesEnabled")
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
                
                tableView.cellForRow(at: [1, 1])!.isUserInteractionEnabled = true
                tableView.cellForRow(at: [1, 1])!.contentView.alpha = 1
                
                tableView.cellForRow(at: [1, 2])!.isUserInteractionEnabled = true
                tableView.cellForRow(at: [1, 2])!.contentView.alpha = 1
            }
        }
            
        return indexPath
        
    }
    
    // prepare ColorPickerVC to handle selection
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let ColorPickerVC = segue.destination as? ColorPickerViewController else { return }
        ColorPickerVC.user = playerSelected
        
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

    // -------------------------------------------------------------------
    // MARK: - IBActions (unwind segues)
    // -------------------------------------------------------------------

extension DefaultsViewController {
    @IBAction func tableColorChanged(_: UIStoryboardSegue) {
        firstPlayerColorLabel.text = NSLocalizedString(
            Configuration.value(defaultValue: "white", forKey: "firstPlayerTableColor"), comment: "")
        secondPlayerColorLabel.text = NSLocalizedString(
            Configuration.value(defaultValue: "blue", forKey: "secondPlayerTableColor"), comment: "")
        
        tableView.reloadData()
    }
}

