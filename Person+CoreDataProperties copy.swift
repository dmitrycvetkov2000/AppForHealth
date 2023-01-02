//
//  Person+CoreDataProperties.swift
//  
//
//  Created by Дмитрий Цветков on 19.12.2022.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var gender: String?
    @NSManaged public var age: Int16
    @NSManaged public var weight: Int16
    @NSManaged public var height: Int16
    @NSManaged public var levelOfActivity: String?
    @NSManaged public var goal: String?

}
