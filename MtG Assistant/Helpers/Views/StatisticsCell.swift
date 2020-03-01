//
//  StatisticCell.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 16.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class StatisticsCell: UITableViewCell {
    
    // -------------------------------------------------------------------
    // MARK: - IBOutlets
    // -------------------------------------------------------------------

    @IBOutlet var competitorsLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!

    // -------------------------------------------------------------------
    // MARK: - Properties
    // -------------------------------------------------------------------

    var statistics: StatisticsHeadline? {
        didSet {
            guard let statistics = statistics else { return }

            competitorsLabel.text = statistics.firstPlayer + " / " + statistics.secondPlayer
            dateLabel.text = statistics.date
            resultLabel.text = statistics.result
        }
    }
}
