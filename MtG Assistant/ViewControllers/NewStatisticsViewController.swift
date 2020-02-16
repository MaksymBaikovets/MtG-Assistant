//
//  NewStatisticsViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 05.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class NewStatisticsViewController: UITableViewController {
    @IBAction func cancelButton(_: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func doneButton(_: UIBarButtonItem) {}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
