//
//  ParametrsInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 18.12.2022.
//

import UIKit
import CoreData


protocol ParametrsInteractorProtocol: AnyObject {
    func writeParametersToBD(age: String, gender: String, goal: String, height: String, levelOfActivity: String, weight: String) -> String
    func calculateAndSaveNumberOfWater()
    func culculationAndSaveIMT()
    
    func culculationCalories()
    
    func saveAllResults()
}

class ParametrsInteractor: ParametrsInteractorProtocol {
    
    weak var presenter: ParametrsPresenterProtocol?
    let defaults = UserDefaults.standard
    let token = DefaultsManager.instance.defaults.string(forKey: "token")
    
    func writeParametersToBD(age: String, gender: String, goal: String, height: String, levelOfActivity: String, weight: String) -> String {
        let managedObject = Person()
        
        managedObject.age = Int16(age) ?? 0
        managedObject.gender = gender
        managedObject.goal = goal
        managedObject.height = Int16(height) ?? 0
        managedObject.levelOfActivity = levelOfActivity
        managedObject.weight = Int16(weight) ?? 0
        managedObject.token = defaults.string(forKey: "token") ?? ""
        
        return gender
    }
    
    func calculateAndSaveNumberOfWater() {

        var numberOfWater: Int16? = 0
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                if defaults.string(forKey: "token") == result.token {
                    if result.gender == Genders.man.rawValue {
                        numberOfWater = Int16(result.weight &* 35)
                    } else if result.gender == Genders.woman.rawValue {
                        numberOfWater = Int16(result.weight &* 31)
                    }
                    result.reccomendWater = abs(Int16(numberOfWater ?? 0))
                }
            }
        } catch {
            print(error)
        }
    }
    
    func culculationAndSaveIMT() {
        var imtText: String = ""
        
        imtText = IMTEnum.notSuccess.rawValue
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                if defaults.string(forKey: "token") == result.token {
                    let squareOfHeight: Int = Int(result.height) * Int(result.height)
                    
                    let squareOfHeightDel = Float(result.weight) / Float(squareOfHeight)
                    
                    let imt = Float(squareOfHeightDel * 10000.0)
                        
                    if result.gender == Genders.man.rawValue && result.age < 65 {
                            switch true {
                            case imt <= 18.5:
                                imtText = IMTEnum.underWeight.rawValue
                                break
                            case imt > 18.5 && imt <= 24.9:
                                imtText = IMTEnum.norma.rawValue
                                break
                            case imt > 24.9 && imt <= 29.9:
                                imtText = IMTEnum.excessWeight.rawValue
                                break
                            case imt > 29.9:
                                imtText = IMTEnum.overWeight.rawValue
                                break
                            default:
                                imtText = IMTEnum.notSuccess.rawValue
                            }
                        }
                        
                    if result.gender == Genders.man.rawValue && result.age >= 65 && result.age < 74 {
                            switch true {
                            case imt <= 22:
                                imtText = IMTEnum.underWeight.rawValue
                                break
                            case imt > 22 && imt <= 26.9:
                                imtText = IMTEnum.norma.rawValue
                                break
                            case imt > 26.9 && imt <= 29.9:
                                imtText = IMTEnum.excessWeight.rawValue
                                break
                            case imt > 29.9:
                                imtText = IMTEnum.overWeight.rawValue
                                break
                            default:
                                print("Не выявлен")
                                imtText = IMTEnum.notSuccess.rawValue
                            }
                        }
                        
                    if result.gender == Genders.man.rawValue && result.age >= 75{
                            switch true {
                            case imt <= 23:
                                imtText = IMTEnum.underWeight.rawValue
                                break
                            case imt > 23 && imt <= 27.9:
                                imtText = IMTEnum.norma.rawValue
                                break
                            case imt > 27.9 && imt <= 29.9:
                                imtText = IMTEnum.excessWeight.rawValue
                                break
                            case imt > 29.9:
                                imtText = IMTEnum.overWeight.rawValue
                                break
                            default:
                                print("Не выявлен")
                                imtText = IMTEnum.notSuccess.rawValue
                            }
                        }
                        
                    if result.gender == Genders.woman.rawValue && result.age < 65 {
                            switch true {
                            case imt <= 17:
                                imtText = IMTEnum.underWeight.rawValue
                                break
                            case imt > 17 && imt <= 24.2:
                                imtText = IMTEnum.norma.rawValue
                                break
                            case imt > 24.2 && imt <= 29.2:
                                imtText = IMTEnum.excessWeight.rawValue
                                break
                            case imt > 29.2:
                                imtText = IMTEnum.overWeight.rawValue
                                break
                            default:
                                print("Не выявлен")
                                imtText = IMTEnum.notSuccess.rawValue
                            }
                        }
                        
                    if result.gender == Genders.woman.rawValue && result.age >= 65 && result.age < 74 {
                            switch true {
                            case imt <= 21.4:
                                imtText = IMTEnum.underWeight.rawValue
                                break
                            case imt > 21.4 && imt <= 26:
                                imtText = IMTEnum.norma.rawValue
                                break
                            case imt > 26 && imt <= 29.3:
                                imtText = IMTEnum.excessWeight.rawValue
                                break
                            case imt > 29.3:
                                imtText = IMTEnum.overWeight.rawValue
                                break
                            default:
                                print("Не выявлен")
                                imtText = IMTEnum.notSuccess.rawValue
                            }
                        }
                        
                    if result.gender == Genders.woman.rawValue && result.age >= 75 {
                            switch true {
                            case imt <= 22.6:
                                imtText = IMTEnum.underWeight.rawValue
                                break
                            case imt > 22.6 && imt <= 27.4:
                                imtText = IMTEnum.norma.rawValue
                                break
                            case imt > 27.4 && imt <= 29.6:
                                imtText = IMTEnum.excessWeight.rawValue
                                break
                            case imt > 29.6:
                                imtText = IMTEnum.overWeight.rawValue
                                break
                            default:
                                print("Не выявлен")
                                imtText = IMTEnum.notSuccess.rawValue
                            }
                        }
                    result.imt = imtText
                }
            }
        } catch {
            print(error)
        }
    }
    
    func culculationCalories() {
        // Формула для мужчин BMR = 88,36 + (13,4 × вес в кг) + (4,8 × рост в см) – (5,7 × возраст в годах).
        //Формула для женщин BMR = 447,6 + (9,2 × вес в кг) + (3,1 × рост в см) – (4,3 × возраст в годах).
        
        var bmr: Int16? = 0
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                if defaults.string(forKey: "token") == result.token {
                    if result.gender == Genders.man.rawValue {
                        let weightBMR = 13.4 * Double(result.weight)
                        let heughtBMR = 4.8 * Double(result.height)
                        let ageBMR = 5.7 * Double(result.age)
                        bmr = Int16(88.36 + weightBMR + heughtBMR - ageBMR)
                    } else if result.gender == Genders.woman.rawValue {
                        let weightBMR = 9.2 * Double(result.weight)
                        let heughtBMR = 3.1 * Double(result.height)
                        let ageBMR = 4.3 * Double(result.age)
                        bmr = Int16(447.6 + weightBMR + heughtBMR - ageBMR)
                    }
                    
                    switch result.levelOfActivity {
                    case LevelOfActivityEnum.low.rawValue:
                        bmr = Int16(Double(bmr ?? 0) * 1.2)
                        break
                        case LevelOfActivityEnum.middle.rawValue:
                        bmr = Int16(Double(bmr ?? 0) * 1.5)
                        break
                        case LevelOfActivityEnum.hight.rawValue:
                        bmr = Int16(Double(bmr ?? 0) * 1.8)
                        break
                    default:
                        print("error")
                    }
                    result.reccomendCcal = Int16(bmr ?? 0)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func saveAllResults() {
        CoreDataManager.instance.saveContext()
    }
}
