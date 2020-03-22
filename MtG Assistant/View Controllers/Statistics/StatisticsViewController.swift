//
//  StatisticsViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 04.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class StatisticsViewController: UITableViewController {
    
    var statisticsDataSource = StatisticsDataSource()
    var selectedItem: StatisticsHeadline?
    var indexPathOfCell: IndexPath?
    
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
    
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        selectedItem = statisticsDataSource.game(at: indexPath)
        indexPathOfCell = indexPath
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? StatisticsDetailsViewController else { return }
        destinationVC.data = selectedItem
        destinationVC.destinationTable = self.tableView
        destinationVC.self.indexPathOfCell = indexPathOfCell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         
        if editingStyle == .delete {
            statisticsDataSource.delete(to: tableView, at: indexPath)
        }
     }
    
    override func viewDidAppear(_ animated: Bool) {
        statisticsDataSource = StatisticsDataSource()
        UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
    }
    
}

    // -------------------------------------------------------------------
    // MARK: Extensions to UITableViewController
    // -------------------------------------------------------------------

extension StatisticsViewController {
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        let itemsCount = statisticsDataSource.numberOfGames()
        if itemsCount == 0 {
            self.tableView.setEmptyMessage(NSLocalizedString("No statistics yet", comment: ""))
        } else {
            self.tableView.restore()
        }
        
        return itemsCount
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    
//    guard let cell = tableView.cellForRow(at: indexPath) as! StatisticsCell? else { return }
//    cell.statistics = game(at: indexPath)
//    
//    tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
}
