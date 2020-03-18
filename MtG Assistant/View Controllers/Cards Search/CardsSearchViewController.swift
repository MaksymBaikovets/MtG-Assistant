//
//  CardsSearchViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 01.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit
import Alamofire

class CardsSearchViewController: UITableViewController {

    var cards: [Card] = []
    
    var items: [CardDisplayable] = []
    var selectedItem: CardDisplayable?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.tableFooterView = UIView()

    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.title = NSLocalizedString("Cards Search", comment: "")
    }

    // -------------------------------------------------------------------
    // MARK: - UITableViewController methods
    // -------------------------------------------------------------------
    
    // empty table placeholder if empty
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count == 0 {
            self.tableView.setEmptyMessage(
                NSLocalizedString("Type a request to start a search", comment: ""))
        } 
        
        // return rows count
        return items.count
    }

    // fill the rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.typeLine

        return cell
    }
    
    // define if row selected + remember position
    var position = CGPoint()
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        position = tableView.contentOffset
    }
    
    // auto-scroll handling
    override func viewDidAppear(_ animated: Bool) {
        if position != CGPoint() {
            self.tableView.setContentOffset(position, animated: true)
        } else {
            self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
       position = tableView.contentOffset
    }
    
    // define which row selected
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = items[indexPath.row]
        return indexPath
    }

    // prepare CardDetailsVC to receive data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let CardDetailsVC = segue.destination as? CardDetailViewController else { return }
        CardDetailsVC.data = selectedItem
        
    }

}

    // -------------------------------------------------------------------
    // MARK: - UISearchBarDelegate extension
    // -------------------------------------------------------------------

extension CardsSearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let cardName = searchBar.text else { return }
        cardsSerch(for: cardName)
        
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        searchBar.showsCancelButton = false

        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        self.searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        items = cards
        
        self.tableView.restore()
        tableView.reloadData()
    }
    
}

    // -------------------------------------------------------------------
    // MARK: - Alamofire
    // -------------------------------------------------------------------

extension CardsSearchViewController {
    
    func cardsSerch(for name: String = "") {
        
        // Create the activity indicator
        let activityIndicator = UIActivityIndicatorView()
        
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: view.frame.size.width * 0.5, y: view.frame.size.height * 0.5)
        
        activityIndicator.startAnimating()
        
        // Proceed request
        let url = "https://api.scryfall.com/cards/search"
        let parameters: [String: String] = ["q": name, "unique": "cards", "order": "name"]
            
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: CardsSearch.self) {
                (response) in guard let cards = response.value else {
                    self.items = []
                    self.tableView.reloadData()

                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                    self.tableView.setEmptyMessage(
                        NSLocalizedString("Nothing found by your request", comment: ""))
                    
                    return
                }
                
                // Restore tableView after request comlete
                self.tableView.restore()
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                
                self.cards = cards.data
                self.items = cards.data
                
                self.tableView.reloadData()
        }
    }
}
