//
//  CardRulings.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 23.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

struct CardRulings: Decodable {
        
    let object: String
    let hasMore: Bool
    let data: [Rule]
  
    enum CodingKeys: String, CodingKey {
        case object = "object"
        case hasMore = "has_more"
        case data = "data"
    }
    
}
