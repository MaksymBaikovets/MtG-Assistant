//
//  CardDisplayable.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 01.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

protocol CardDisplayable {
    var name: String { get }
    var typeLine: String { get }
    var setName: String? { get }
    var oracleText: String? { get }
    var flavorText: String? { get }
    var imageUris: CardImages? { get }

// TODO: Implement vars with labels
//    var item2: (label: String, value: String) { get }
//    var item3: (label: String, value: String) { get }
    
}
