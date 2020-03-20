//
//  SharedPreferences.swift
//  MtG Assistant
//
//  Created by Maksym Baikovets on 19.03.2020.
//  Copyright © 2020 Maksym Baikovets. All rights reserved.
//

import UIKit

class Configuration {

    static func value<T>(defaultValue: T, forKey key: String) -> T{

        let preferences = UserDefaults.standard
        return preferences.object(forKey: key) == nil ? defaultValue : preferences.object(forKey: key) as! T
    }

    static func value(value: Any, forKey key: String){

        UserDefaults.standard.set(value, forKey: key)
    }

}
