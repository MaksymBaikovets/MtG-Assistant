//
//  Rule.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 23.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

struct Rule: Decodable {
        
    let object: String
    let oracleId: String
    let source: String
    let publishedAt: String
    let comment: String
  
    enum CodingKeys: String, CodingKey {
        case object = "object"
        case oracleId = "oracle_id"
        case source = "source"
        case publishedAt = "published_at"
        case comment = "comment"
    }
    
}
