//
//  RealmManager.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 22.04.2023.
//

import Foundation
import RealmSwift

class RealmManager {
    static let instance = RealmManager()
    
    var realm = try! Realm()
    var products: Results<ProductToday>?
    var userRealm: Results<UserRealm>?
    
    func fillProducts() {
        self.products = self.realm.objects(ProductToday.self) // Заполняем массив базы данных
    }
    
    func fillUserRealm() {
        self.userRealm = self.realm.objects(UserRealm.self)
    }
    
}
