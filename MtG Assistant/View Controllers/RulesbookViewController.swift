//
//  RulesbookViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 16.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit
import Foundation

class RulesbookViewController: UIViewController {
    
    @IBOutlet weak var rulesSearchBar: UISearchBar!
    @IBOutlet var rulings: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rulesSearchBar.delegate = self
        rulings.font = UIFont(name: "SFProDisplay", size: 12)

        guard let filePath = Bundle.main.path(
            forResource: "MagicCompRules_20200122", ofType: "txt") else { return }
        
        do {
            let content = try String(contentsOfFile:filePath, encoding: String.Encoding.utf8)
            rulings.text = content
        } catch {
            print("nil")
        }
        
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.title = NSLocalizedString("Rules Book", comment: "")
    }
    
    func ruleSearch(_ searchQuery: String) -> [String.Index] {
        guard let content = rulings.text else { return [] }
        let query = searchQuery

        var searchRange = content.startIndex..<content.endIndex
        var indices: [String.Index] = []

        while let range = content.range(of: query, options: .caseInsensitive, range: searchRange) {
            searchRange = range.upperBound..<searchRange.upperBound
            indices.append(range.lowerBound)
        }

        print(indices)
        return indices
    }

}

    // -------------------------------------------------------------------
    // MARK: - UISearchBarDelegate extension
    // -------------------------------------------------------------------

extension RulesbookViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ rulesSearchBar: UISearchBar) -> Bool {
        rulesSearchBar.showsCancelButton = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ rulesSearchBar: UISearchBar) {
//        let rules = rulings.text!
//        guard let ruleName = rulesSearchBar.text else { return }

//        ruleSearch(ruleName)
//        heightForLabel(text: rules)
        
        rulesSearchBar.showsCancelButton = false
        rulesSearchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ rulesSearchBar: UISearchBar) {
        self.rulesSearchBar.endEditing(true)
        rulesSearchBar.showsCancelButton = false

        rulesSearchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ rulesSearchBar: UISearchBar) {
        rulesSearchBar.text = nil
        self.rulesSearchBar.endEditing(true)
        rulesSearchBar.showsCancelButton = false
        rulesSearchBar.resignFirstResponder()
        
//        items = cards
        
//        self.tableView.restore()
//        tableView.reloadData()
    }
    
    func heightForLabel(text: String) -> CGFloat {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let label: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: CGFloat.greatestFiniteMagnitude))
        
        label.font = UIFont(name: "SFProDisplay", size: 12)
        label.text = text
        label.sizeToFit()

        print(label.frame.height)
        return label.frame.height

    }
    
}

// -------------------------------------------------------------------
// MARK: - String.Index extensions
// -------------------------------------------------------------------

extension StringProtocol {
    func indexDistance(of element: Element) -> Int? { firstIndex(of: element)?.distance(in: self) }
    func indexDistance<S: StringProtocol>(of string: S) -> Int? { range(of: string)?.lowerBound.distance(in: self) }
}

extension Collection {
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}

extension String.Index {
    func distance<S: StringProtocol>(in string: S) -> Int { string.distance(to: self) }
}
