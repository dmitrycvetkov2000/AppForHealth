//
//  ModelOfDataForFindTable.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 03.03.2023.
//

import Foundation
import RealmSwift

struct ModelOfDataForFindTable {
    var name = [String]()
    var proteins = [Double]()
    var fats = [Double]()
    var carb = [Double]()
    var ccal = [Int]()
    var isSearching: Bool = true
}
