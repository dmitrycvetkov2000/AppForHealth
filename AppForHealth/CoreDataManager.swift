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
                print("В базе данных  \(result.age), \(result.gender), \(result.goal), \(result.height), \(result.levelOfActivity), \(result.weight)")
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
}
