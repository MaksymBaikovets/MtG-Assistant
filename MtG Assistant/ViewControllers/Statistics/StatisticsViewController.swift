//
//  StatisticsViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 04.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit
import CoreData

class StatisticsViewController: UITableViewController {
    var statisticsDataSource = StatisticsDataSource()
    var selectedItem: StatisticsHeadline?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override  func awakeFromNib() {
        super.awakeFromNib()
        self.title = NSLocalizedString("Statistics", comment: "")
    }
    
    // -------------------------------------------------------------------
    // MARK: - Table view data source
    // -------------------------------------------------------------------

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = statisticsDataSource.game(at: indexPath)
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? StatisticsDetailsViewController else { return }
        destinationVC.data = selectedItem
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         
        if editingStyle == .delete {
            statisticsDataSource.delete(to: tableView, at: indexPath)
        }
     }
    
}

// -------------------------------------------------------------------
// MARK: Extensions to UITableViewController
// -------------------------------------------------------------------

extension StatisticsViewController {
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        statisticsDataSource.numberOfGames()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticsCell", for: indexPath) as! StatisticsCell
        
        cell.statistics = statisticsDataSource.game(at: indexPath)
        return cell
    }
}

// -------------------------------------------------------------------
// MARK: - IBActions (unwind segues)
// -------------------------------------------------------------------

extension StatisticsViewController {
    @IBAction func cancelSavingStatistics(_: UIStoryboardSegue) {}

    @IBAction func saveStatistics(_ segue: UIStoryboardSegue) {
        guard
            let newStatisticsDetailsViewController = segue.source as? NewStatisticsViewController,
            let statistics = newStatisticsDetailsViewController.statistics
        else {
            return
        }
        statisticsDataSource.append(haedline: statistics, to: tableView)
    }
}
