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
    
    func reloadNumberOfWater(gender: String?, weight: Int16) -> Int16
    func reloadNumberOfCcal(gender: String?, weight: Int16, height: Int16, age: Int16, levelOfActivity: String?) -> Int16
    func reloadIMT(height: Int16, weight: Int16, gender: String?, age: Int16) -> String
    
    func checkNumberOfWater() -> Int16
    
    func getElement<T>(elementName: String) -> T?
}

class SettingInteractor: SettingInteractorProtocol {

    weak var presenter: SettingPresenterProtocol?
    let firebaseService = FirebaseService()
    
    var bmr: Int16? = 0 // Количество калорий
    var imtText: String = "Не выявлен"
    var numberOfWater: Int16 = 0
    
    func checkNumberOfWater() -> Int16 {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                return result.numberOfWater
            }
        } catch {
            print(error)
        }
        return 0
    }
    
    func reloadNumberOfWater(gender: String?, weight: Int16) -> Int16 {
        var numberOfWater: Int16? = 0
        
        if gender == Genders.man.rawValue {
            numberOfWater = Int16(weight &* 35)
        } else if gender == Genders.woman.rawValue {
            numberOfWater = Int16(weight &* 31)
        }
        return abs(Int16(numberOfWater ?? 0))
    }
    
    func reloadNumberOfCcal(gender: String?, weight: Int16, height: Int16, age: Int16, levelOfActivity: String?) -> Int16 {
    
        if gender == Genders.man.rawValue {
            let weightBMR = 13.4 * Double(weight)
            let heughtBMR = 4.8 * Double(height)
            let ageBMR = 5.7 * Double(age)
            bmr = Int16(88.36 + (weightBMR) + (heughtBMR) - (ageBMR))
        } else if gender == Genders.woman.rawValue {
            let weightBMR = 9.2 * Double(weight)
            let heughtBMR = 3.1 * Double(height)
            let ageBMR = 4.3 * Double(age)
            bmr = Int16(447.6 + (weightBMR) + (heughtBMR) - (ageBMR))
        }
        
        switch levelOfActivity {
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
        return Int16(bmr ?? 0)
    }
    
    func reloadIMT(height: Int16, weight: Int16, gender: String?, age: Int16) -> String {
        let squareOfHeight: Int = Int(height) * Int(height)
        
        let squareOfHeightDel = Float(weight) / Float(squareOfHeight)
        
        let imt = Float(squareOfHeightDel * 10000.0)
            
        if gender == Genders.man.rawValue && age < 65 {
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
                    print("NO")
                    imtText = IMTEnum.notSuccess.rawValue
                }
            }
            
        if gender == Genders.man.rawValue && age >= 65 && age < 74 {
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
            
        if gender == Genders.man.rawValue && age >= 75{
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
            
        if gender == Genders.woman.rawValue && age < 65{
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
            
        if gender == Genders.woman.rawValue && age >= 65 && age < 74 {
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
            
        if gender == Genders.woman.rawValue && age >= 75 {
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
        return imtText
    }
    
    func signOut() {
        firebaseService.signOutFromAcc(presenter: presenter)
    }
    
    func getElement<T>(elementName: String) -> T? {
        return CoreDataManager.instance.getElementFromBD(find: elementName)
    }
    
    func writeParametrsInBD(gender: String, age: String, weight: String, height: String, levelOfActivity: String, goal: String) {
        numberOfWater = self.checkNumberOfWater()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                result.gender = gender
                result.goal = goal
                result.age = Int16(age) ?? 0
                result.height = Int16(height) ?? 0
                result.weight = Int16(weight) ?? 0
                result.levelOfActivity = levelOfActivity
                result.imt = self.reloadIMT(height: Int16(height) ?? 0, weight: Int16(weight) ?? 0, gender: gender, age: Int16(age) ?? 0)
                result.reccomendWater = self.reloadNumberOfWater(gender: gender, weight: Int16(weight) ?? 0)
                result.reccomendCcal = self.reloadNumberOfCcal(gender: gender, weight: Int16(weight) ?? 0, height: Int16(height) ?? 0, age: Int16(age) ?? 0, levelOfActivity: levelOfActivity)
            }
        } catch {
            print(error)
        }
        
        CoreDataManager.instance.saveContext()
        presenter?.showAlert()
    }
}
