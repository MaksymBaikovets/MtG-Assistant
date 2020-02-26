//
//  StatisticsHeadlines.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 16.02.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

struct StatisticsHeadline: Codable {
    var competitors: String
    var date: String
    var result: String
    var firstPlayerDeck: String
    var secondPlayerDeck: String
}
