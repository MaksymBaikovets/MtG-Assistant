//
//  CardImages.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 02.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

struct CardImages: Decodable {
        
    let normal: String
    let large: String
    let png: String
  
    enum CodingKeys: String, CodingKey {
        case normal = "normal"
        case large = "large"
        case png = "png"
    }
    
}
