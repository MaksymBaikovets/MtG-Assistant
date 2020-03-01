//
//  CardsSearch.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 01.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

struct CardsSearch: Decodable {
    
    let totalCards: Int
    let data: [Card]
  
    enum CodingKeys: String, CodingKey {
        case totalCards = "total_cards"
        case data = "data"
    }
    
}
