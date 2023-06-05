//
//  DefaultsManager.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 05.06.2023.
//

import Foundation

class DefaultsManager {
    static let instance = DefaultsManager()
    let defaults = UserDefaults.standard
    
    func setValue<T>(value: T, key: String) {
        defaults.set(value, forKey: key)
    }
    
    func getValue(key: String) {
        defaults.object(forKey: key)
    }
}
