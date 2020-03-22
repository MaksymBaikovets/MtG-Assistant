//
//  GesturesChangeViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 23.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class GesturesChangeViewController: UITableViewController {

    var gestureType: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        
        tableView.tableFooterView = UIView()
        
        if gestureType == 0 {
            let color = Configuration.value(defaultValue: "counters20", forKey: "singleTapGesture")

            switch color {
            case "counters20":
                tableView.cellForRow(at: [0, 0])?.accessoryType = UITableViewCell.AccessoryType.checkmark
            case "counters40":
                tableView.cellForRow(at: [0, 1])?.accessoryType = UITableViewCell.AccessoryType.checkmark
            case "countersCustom":
                tableView.cellForRow(at: [0, 2])?.accessoryType = UITableViewCell.AccessoryType.checkmark
            case "countersSave":
                tableView.cellForRow(at: [0, 3])?.accessoryType = UITableViewCell.AccessoryType.checkmark
            case "countersNone":
                tableView.cellForRow(at: [0, 4])?.accessoryType = UITableViewCell.AccessoryType.checkmark
            default:
                return
            }

        } else if gestureType == 1 {
            let color = Configuration.value(defaultValue: "counters40", forKey: "doubleTapGesture")

            switch color {
            case "counters20":
                tableView.cellForRow(at: [0, 0])?.accessoryType = UITableViewCell.AccessoryType.checkmark
            case "counters40":
                tableView.cellForRow(at: [0, 1])?.accessoryType = UITableViewCell.AccessoryType.checkmark
            case "countersCustom":
                tableView.cellForRow(at: [0, 2])?.accessoryType = UITableViewCell.AccessoryType.checkmark
            case "countersSave":
                tableView.cellForRow(at: [0, 3])?.accessoryType = UITableViewCell.AccessoryType.checkmark
            case "countersNone":
                tableView.cellForRow(at: [0, 4])?.accessoryType = UITableViewCell.AccessoryType.checkmark
            default:
                return
            }
        }
        
        if self.traitCollection.userInterfaceStyle == .dark {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0x000000)
        } else {
            tableView.backgroundColor = RGBColor().UIColorFromRGB(rgbValue: 0xF6F5FB)
        }

    }
    
    private func commonInit() {
        guard let gestureType = gestureType else { return }
        self.gestureType = gestureType
        
    }
    
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()
           tableView.layoutIfNeeded()
        }
    
//    override  func awakeFromNib() {
//        super.awakeFromNib()
//        self.title = NSLocalizedString("Gesture Select", comment: "")
//    }
    
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

        var userSelection: String = ""
        if gestureType == 0 {
            userSelection = "singleTapGesture"
        } else if gestureType == 1 {
            userSelection = "doubleTapGesture"
        }

        if cell.tag == 0 {
            Configuration.value(value: "counters20", forKey: userSelection)

        } else if cell.tag == 1 {
            Configuration.value(value: "counters40", forKey: userSelection)

        } else if cell.tag == 2 {
            Configuration.value(value: "countersCustom", forKey: userSelection)

        } else if cell.tag == 3 {
            Configuration.value(value: "countersSave", forKey: userSelection)

        } else if cell.tag == 4 {
            Configuration.value(value: "countersNone", forKey: userSelection)

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

        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        footerView.backgroundColor = UIColor.clear
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 5 ,width: footerView.frame.width, height: 60))
        
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.backgroundColor = UIColor.clear
        
        titleLabel.textColor = UIColor.lightGray
        titleLabel.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        titleLabel.text = "Selection changes goes to live right after selection."
        
        footerView.addSubview(titleLabel)
        tableView.tableFooterView = footerView
        
        return footerView
    }

    override func tableView(_ tableView: UITableView,
                            heightForFooterInSection section: Int) -> CGFloat {
        return 60
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
