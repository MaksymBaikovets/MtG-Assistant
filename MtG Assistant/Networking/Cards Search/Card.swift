//
//  Card.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 01.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

struct Card: Decodable {
    
    let name: String
    let typeLine: String
    let setName: String?
    let oracleText: String?
    let flavorText: String?
    let imageUris: CardImages?
  
    enum CodingKeys: String, CodingKey {
        case name
        case typeLine = "type_line"
        case setName = "set_name"
        case oracleText = "oracle_text"
        case flavorText = "flavor_text"
        case imageUris = "image_uris"
    }
    
}

extension Card: CardDisplayable {
    
    var cardName: String {
        name
    }

    var cardType: String {
        "\(String(typeLine))"
    }
    
    var nameOfSet: String {
        "\(String(setName ?? ""))"
    }

    var oracleDescription: (label: String, value: String) {
        ("Oracle Text: ", oracleText ?? "")
    }

    var flavorDescription: (label: String, value: String) {
        ("Flavor Text: ", flavorText ?? "")
    }
    
    var images: CardImages? {
        imageUris
    }
    
}
