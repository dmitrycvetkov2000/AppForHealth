//
//  Person+CoreDataClass.swift
//  
//
//  Created by Дмитрий Цветков on 19.12.2022.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Person"), insertInto: CoreDataManager.instance.context)
    }
}
