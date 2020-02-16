//
//  StatisticsDataModel.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 13.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class StatisticsDataSource: NSObject {
    // MARK: - Properties

    var headlines: [StatisticsHeadline]

    static func generatePlayersData() -> [StatisticsHeadline] {
        return [
            StatisticsHeadline(id: 1, title: "Maksym vs Ann", text: "03.02.2020", result: ""),
            StatisticsHeadline(id: 2, title: "Ann vs Roman", text: "26.01.2020", result: ""),
            StatisticsHeadline(id: 3, title: "Roman vs Maksym", text: "24.01.2020", result: ""),
        ]
    }

    // MARK: - Initializers

    override init() {
        headlines = StatisticsDataSource.generatePlayersData()
    }

    // MARK: - Datasource Methods

    func numberOfPlayers() -> Int {
        headlines.count
    }

    func append(player: StatisticsHeadline, to tableView: UITableView) {
        headlines.append(player)
        tableView.insertRows(at: [IndexPath(row: headlines.count - 1, section: 0)], with: .automatic)
    }

    func player(at indexPath: IndexPath) -> StatisticsHeadline {
        headlines[indexPath.row]
    }
}
