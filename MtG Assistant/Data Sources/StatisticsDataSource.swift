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

    static func generateStatisticsData() -> [StatisticsHeadline] {
        return [
            StatisticsHeadline(id: 1, competitors: "Maksym : Ann", date: "03.02.2020", result: "20 : -7"),
            StatisticsHeadline(id: 2, competitors: "Ann : Roman", date: "26.01.2020", result: "3 : -1"),
            StatisticsHeadline(id: 3, competitors: "Roman : Maksym", date: "24.01.2020", result: "-4 : 5"),
        ]
    }

    // MARK: - Initializers

    override init() {
        headlines = StatisticsDataSource.generateStatisticsData()
    }

    // MARK: - Datasource Methods

    func numberOfGames() -> Int {
        headlines.count
    }

    func append(haedline: StatisticsHeadline, to tableView: UITableView) {
        headlines.append(haedline)
        tableView.insertRows(at: [IndexPath(row: headlines.count - 1, section: 0)], with: .automatic)
    }

    func game(at indexPath: IndexPath) -> StatisticsHeadline {
        headlines[indexPath.row]
    }
}
