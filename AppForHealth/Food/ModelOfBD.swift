//
//  ModelOfBD.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.03.2023.
//

import RealmSwift

class Product: Object {
    @objc dynamic var name = ""
    @objc dynamic var proteins = 0.0
    @objc dynamic var fats = 0.0
    @objc dynamic var carb = 0.0
    @objc dynamic var ccal: Int = 0
    @objc dynamic var token: String = ""
}

class ProductToday: Object {
    @objc dynamic var name = ""
    @objc dynamic var weight: Int = 0
    @objc dynamic var proteins = 0.0
    @objc dynamic var fats = 0.0
    @objc dynamic var carb = 0.0
    @objc dynamic var ccal: Int = 0
    @objc dynamic var time = ""
    @objc dynamic var date: String = ""
    @objc dynamic var token: String = ""
}

class UserRealm: Object {
    @objc dynamic var nameOfUser = ""
    @objc dynamic var token = ""
}
