//
//  CoreDataManager.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 19.12.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    
    private init() {}
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    // Описание сущности
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
    
    func isEmptyCoreData() -> Bool {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            
            for result in results as! [Person] {
                print("В базе данных:  Возраст - \(result.age), Пол - \(String(describing: result.gender)), Цель - \(String(describing: result.goal)), Рост - \(result.height), Активность - \(String(describing: result.levelOfActivity)), Вес - \(result.weight), Рек воды - \(result.reccomendWater), Рек ккал - \(result.reccomendCcal)")
            }
            
            if results.isEmpty {
                print("База данных пустая")
                return true
            } else {
                print("База данных не пустая")
                print(results.count)
                return false
            }
            
        } catch {
            print(error)
            return true
        }
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AppForHealth")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getElementFromBD<T>(find: String) -> T? {
        var searchElement: T? = nil
        
        var intValue: Int16? = nil
        var dict: [String: Int16]? = nil
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                searchElement = result.value(forKey: find) as? T
                intValue = result.value(forKey: find) as? Int16
                dict = result.value(forKey: find) as? [String: Int16]
                
                if let searchElement = searchElement {
                    return searchElement
                }
                if let dict = dict {
                    searchElement = dict as? T
                    return searchElement
                } else if let intValue = intValue {
                    searchElement = intValue as? T
                    return searchElement
                }
            }
        } catch {
            print(error)
        }
        return searchElement
    }
    func insert<T: NSManagedObject>(object: T) {
        let context = persistentContainer.viewContext
        
        context.insert(object)
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
