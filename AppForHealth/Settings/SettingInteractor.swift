//
//  SettingInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 09.01.2023.
//

import Foundation
import CoreData

protocol SettingInteractorProtocol: AnyObject {
    func signOut()
    func writeParametrsInBD(gender: String, age: String, weight: String, height: String, levelOfActivity: String, goal: String)
    func extractionFromBD(mas: inout [String])
}

class SettingInteractor: SettingInteractorProtocol {
    weak var presenter: SettingPresenterProtocol?
    let firebaseService = FirebaseService()
    
    func signOut() {
        firebaseService.signOutFromAcc(presenter: presenter)
    }
    
    func writeParametrsInBD(gender: String, age: String, weight: String, height: String, levelOfActivity: String, goal: String) {
        let managedObject = Person()
        
        managedObject.age = Int16(age) ?? 0
        managedObject.gender = gender
        managedObject.goal = goal
        managedObject.height = Int16(height) ?? 0
        managedObject.levelOfActivity = levelOfActivity
        managedObject.weight = Int16(weight) ?? 0
        
        CoreDataManager.instance.saveContext()
        presenter?.showAlert()
    }
    
    func extractionFromBD(mas: inout [String]) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                print("В базе данных  \(result.age), \(result.gender), \(result.goal), \(result.height), \(result.levelOfActivity), \(result.weight)")
                
                    mas = [String(result.gender ?? ""), String(result.age), String(result.weight), String(result.height), String(result.levelOfActivity ?? ""), String(result.goal ?? "")]
                    
                
            }
        } catch {
            print(error)
        }
        for i in 0..<mas.count {
            print(mas[i])
        }
    }
}
