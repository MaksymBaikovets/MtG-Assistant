//
//  EditStatisticsViewController.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 26.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit
import CoreData

class EditStatisticsViewController: UITableViewController, UITextFieldDelegate {

    var coreHeadlines: [NSManagedObject] = []
    var data: StatisticsHeadline?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print([data])

    }

}
