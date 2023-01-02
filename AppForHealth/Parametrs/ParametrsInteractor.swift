//
//  ParametrsInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 18.12.2022.
//

import UIKit
import CoreData

protocol ParametrsInteractorProtocol: AnyObject {
    func writeParametersToBD(ageTextField: UITextField, gender: String, goal: String, heightTextField: UITextField, levelOfActivity: String, weightTextField: UITextField)
}


class ParametrsInteractor: ParametrsInteractorProtocol {
    
    weak var presenter: ParametrsPresenterProtocol?
    
    func writeParametersToBD(ageTextField: UITextField, gender: String, goal: String, heightTextField: UITextField, levelOfActivity: String, weightTextField: UITextField) {
        let managedObject = Person()
        
        //managedObject.age = age
        managedObject.age = Int16(ageTextField.text ?? "0") ?? 0
        managedObject.gender = gender
        managedObject.goal = goal
        managedObject.height = Int16(heightTextField.text ?? "0") ?? 0
        managedObject.levelOfActivity = levelOfActivity
        managedObject.weight = Int16(weightTextField.text ?? "0") ?? 0
                
        let age = managedObject.age
        let gender = managedObject.gender
        let goal = managedObject.goal
        let height = managedObject.height
        let levelOfActivity = managedObject.levelOfActivity
        let weight = managedObject.weight
        
        
        print("Сохранилось \(age)")
        print("Сохранилось \(gender)")
        print("Сохранилось \(goal)")
        print("Сохранилось \(height)")
        print("Сохранилось \(levelOfActivity)")
        print("Сохранилось \(weight)")
        
        // Сохранение данный в БД

        CoreDataManager.instance.saveContext()
        
        // Извлечение данных из базы данных
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                print("В базе данных  \(result.age), \(result.gender), \(result.goal), \(result.height), \(result.levelOfActivity), \(result.weight)")
            }
        } catch {
            print(error)
        }
        
        //presenter?.didTappedSaveButton()
    }
}
