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
    var items: [Displayable] = []
    var selectedItem: Displayable?

    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.tableFooterView = UIView()
        
        cardsSerch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
        
    }
    
    func disableScrollsToTopPropertyOnAllSubviewsOf(view: UIView) {
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                (scrollView as UIScrollView).scrollsToTop = false
            }
            self.disableScrollsToTopPropertyOnAllSubviewsOf(view: subview as UIView)
        }
    }

    // -------------------------------------------------------------------
    // MARK: Extensions to UITableViewController
    // -------------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.typeLine
        
        print(item.oracleText as Any)
        print(item.flavorText as Any)

        return cell
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = items[indexPath.row]
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? CardDetailViewController else { return }
        destinationVC.data = selectedItem
        
    }

}

    // -------------------------------------------------------------------
    // MARK: - UISearchBarDelegate
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
        tableView.reloadData()
    }
    
}

    // -------------------------------------------------------------------
    // MARK: - Alamofire
    // -------------------------------------------------------------------

extension CardsSearchViewController {
    
    func cardsSerch(for name: String = "") {
        let url = "https://api.scryfall.com/cards/search"
        let parameters: [String: String] = ["q": name, "unique": "cards", "order": "name"]
            
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: CardsSearch.self) {
                (response) in guard let cards = response.value else { return }

                print(cards.data)
                self.cards = cards.data
                self.items = cards.data
                self.tableView.reloadData()
        }
    }
}
