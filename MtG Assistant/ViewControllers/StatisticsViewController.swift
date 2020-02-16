//
//  StatisticsViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 04.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class StatisticsViewController: UITableViewController {
    var headlines = StatisticsDataSource()

    override func viewDidLoad() {
        
// Allows to not minimize header on scroll with a few elements in table (have a bug with selection)
//        let dummyViewHeight = CGFloat(50)
//        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: dummyViewHeight))
//        self.tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)

        super.viewDidLoad()
        tableView.tableFooterView = UIView()

        // Uncomment the following line to preserve selection between presentations
        clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)

        // Configure the cell...
        // let headline = headlines[indexPath.row]

//        cell.textLabel?.text = headlines[indexPath.row].title
//        cell.detailTextLabel?.text = headlines[indexPath.row].text

        cell.textLabel?.font = UIFont(name: "SFProDisplay", size: 14)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // -------------------------------------------------------------------

    // MARK: - NOT IMPLEMENTED

    // -------------------------------------------------------------------

    // MARK: - Table header

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

    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
     }
     */

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

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
     }
     */

    // MARK: - Navigation

    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
