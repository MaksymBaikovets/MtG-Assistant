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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

        // Uncomment the following line to preserve selection between presentations
        clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = statisticsDataSource.game(at: indexPath)
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? StatisticsDetailsViewController else {
            return
        }
    
        destinationVC.data = selectedItem
      
    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
//
//        // Configure the cell...
//        let headline = headlines[indexPath.row]
//
//        cell.textLabel?.text = headlines[indexPath.row].title
//        cell.detailTextLabel?.text = headlines[indexPath.row].text
//
//        cell.textLabel?.font = UIFont(name: "SFProDisplay", size: 14)
//        return cell
//    }

    // -------------------------------------------------------------------

    // MARK: - NOT IMPLEMENTED

    // -------------------------------------------------------------------

    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             // Delete the row from the data source
             tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
             // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
     }
     */

    // MARK: - Custom Table Header experiment

    /*
     override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))

         let label = UILabel()
         label.frame = CGRect.init(x: 20, y: 10, width: headerView.frame.width-10, height: headerView.frame.height-10)
         label.text = "Games Statistics"
         label.font = UIFont(name: "SFProDisplay-Bold", size: 32) // my custom font
         label.textColor = UIColor.orange // my custom colour

         headerView.addSubview(label)

         return headerView

     }

     override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 50
     }
     */
}

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

// MARK: - IBActions

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
