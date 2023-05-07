//
//  ResultInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 19.12.2022.
//

import UIKit
import CoreData

protocol ResultInteractorProtocol: AnyObject {
    func calculateNumberOfWater() -> Int
    func culculationIMT(imtResultLabel: UILabel)
    func culculationCalories() -> Int
}

class ResultInteractor: ResultInteractorProtocol {
    weak var presenter: ResultPresenterProtocol?
    
    func calculateNumberOfWater() -> Int {

        var numberOfWater: Int = 0
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                if result.gender == Genders.man.rawValue {
                    numberOfWater = Int(result.weight) * 35
                } else if result.gender == Genders.woman.rawValue {
                    numberOfWater = Int(result.weight) * 31
                }
                result.reccomendWater = Int16(numberOfWater)
            }
        } catch {
            print(error)
        }
        CoreDataManager.instance.saveContext()
        return Int(numberOfWater)
    }
    
    
    func culculationIMT(imtResultLabel: UILabel) {
        var imtText: String = ""
        
        imtText = IMTEnum.notSuccess.rawValue
        imtResultLabel.text = "ИМТ: Не выявлен"
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {

                let squareOfHeight = Int16(result.height) * Int16(result.height)
                
                let squareOfHeightDel = Float(result.weight) / Float(squareOfHeight)
                
                let imt = Float((squareOfHeightDel) * 10000.0)
                    
                if result.gender == Genders.man.rawValue && result.age < 65 {
                        switch true {
                        case imt <= 18.5:
                            imtText = IMTEnum.underWeight.rawValue
                            imtResultLabel.text = "ИМТ: Недовес"
                            break
                        case imt > 18.5 && imt <= 24.9:
                            imtText = IMTEnum.norma.rawValue
                            imtResultLabel.text = "ИМТ: В норме"
                            break
                        case imt > 24.9 && imt <= 29.9:
                            imtText = IMTEnum.excessWeight.rawValue
                            imtResultLabel.text = "ИМТ: Избыточный вес"
                            break
                        case imt > 29.9:
                            imtText = IMTEnum.overWeight.rawValue
                            imtResultLabel.text = "ИМТ: Ожирение"
                            break
                        default:
                            imtText = IMTEnum.notSuccess.rawValue
                            imtResultLabel.text = "ИМТ: Не выявлен"
                        }
                    }
                    
                if result.gender == Genders.man.rawValue && result.age >= 65 && result.age < 74{
                        switch true {
                        case imt <= 22:
                            imtText = IMTEnum.underWeight.rawValue
                            imtResultLabel.text = "ИМТ: Недовес"
                            break
                        case imt > 22 && imt <= 26.9:
                            imtText = IMTEnum.norma.rawValue
                            imtResultLabel.text = "ИМТ: В норме"
                            break
                        case imt > 26.9 && imt <= 29.9:
                            imtText = IMTEnum.excessWeight.rawValue
                            imtResultLabel.text = "ИМТ: Избыточный вес"
                            break
                        case imt > 29.9:
                            imtText = IMTEnum.overWeight.rawValue
                            imtResultLabel.text = "ИМТ: Ожирение"
                            break
                        default:
                            print("Не выявлен")
                            imtText = IMTEnum.notSuccess.rawValue
                            imtResultLabel.text = "ИМТ: Не выявлен"
                        }
                    }
                    
                if result.gender == Genders.man.rawValue && result.age >= 75{
                        switch true {
                        case imt <= 23:
                            imtText = IMTEnum.underWeight.rawValue
                            imtResultLabel.text = "ИМТ: Недовес"
                            break
                        case imt > 23 && imt <= 27.9:
                            imtText = IMTEnum.norma.rawValue
                            imtResultLabel.text = "ИМТ: В норме"
                            break
                        case imt > 27.9 && imt <= 29.9:
                            imtText = IMTEnum.excessWeight.rawValue
                            imtResultLabel.text = "ИМТ: Избыточный вес"
                            break
                        case imt > 29.9:
                            imtText = IMTEnum.overWeight.rawValue
                            imtResultLabel.text = "ИМТ: Ожирение"
                            break
                        default:
                            print("Не выявлен")
                            imtText = IMTEnum.notSuccess.rawValue
                            imtResultLabel.text = "ИМТ: Не выявлен"
                        }
                    }
                    
                if result.gender == Genders.woman.rawValue && result.age < 65{
                        switch true {
                        case imt <= 17:
                            imtText = IMTEnum.underWeight.rawValue
                            imtResultLabel.text = "ИМТ: Недовес"
                            break
                        case imt > 17 && imt <= 24.2:
                            imtText = IMTEnum.norma.rawValue
                            imtResultLabel.text = "ИМТ: В норме"
                            break
                        case imt > 24.2 && imt <= 29.2:
                            imtText = IMTEnum.excessWeight.rawValue
                            imtResultLabel.text = "ИМТ: Избыточный вес"
                            break
                        case imt > 29.2:
                            imtText = IMTEnum.overWeight.rawValue
                            imtResultLabel.text = "ИМТ: Ожирение"
                            break
                        default:
                            print("Не выявлен")
                            imtText = IMTEnum.notSuccess.rawValue
                            imtResultLabel.text = "ИМТ: Не выявлен"
                        }
                    }
                    
                if result.gender == Genders.woman.rawValue && result.age >= 65 && result.age < 74{
                        switch true {
                        case imt <= 21.4:
                            imtText = IMTEnum.underWeight.rawValue
                            imtResultLabel.text = "ИМТ: Недовес"
                            break
                        case imt > 21.4 && imt <= 26:
                            imtText = IMTEnum.norma.rawValue
                            imtResultLabel.text = "ИМТ: В норме"
                            break
                        case imt > 26 && imt <= 29.3:
                            imtText = IMTEnum.excessWeight.rawValue
                            imtResultLabel.text = "ИМТ: Избыточный вес"
                            break
                        case imt > 29.3:
                            imtText = IMTEnum.overWeight.rawValue
                            imtResultLabel.text = "ИМТ: Ожирение"
                            break
                        default:
                            print("Не выявлен")
                            imtText = IMTEnum.notSuccess.rawValue
                            imtResultLabel.text = "ИМТ: Не выявлен"
                        }
                    }
                    
                if result.gender == Genders.woman.rawValue && result.age >= 75{
                        switch true {
                        case imt <= 22.6:
                            imtText = IMTEnum.underWeight.rawValue
                            imtResultLabel.text = "ИМТ: Недовес"
                            break
                        case imt > 22.6 && imt <= 27.4:
                            imtText = IMTEnum.norma.rawValue
                            imtResultLabel.text = "ИМТ: В норме"
                            break
                        case imt > 27.4 && imt <= 29.6:
                            imtText = IMTEnum.excessWeight.rawValue
                            imtResultLabel.text = "ИМТ: Избыточный вес"
                            break
                        case imt > 29.6:
                            imtText = IMTEnum.overWeight.rawValue
                            imtResultLabel.text = "ИМТ: Ожирение"
                            break
                        default:
                            print("Не выявлен")
                            imtText = IMTEnum.notSuccess.rawValue
                            imtResultLabel.text = "ИМТ: Не выявлен"
                        }
                    }
                result.imt = imtText
            }
        } catch {
            print(error)
        }
        
        CoreDataManager.instance.saveContext()
    }
    
    func culculationCalories() -> Int {
        // Формула для мужчин BMR = 88,36 + (13,4 × вес в кг) + (4,8 × рост в см) – (5,7 × возраст в годах).
        //Формула для женщин BMR = 447,6 + (9,2 × вес в кг) + (3,1 × рост в см) – (4,3 × возраст в годах).
        
        var bmr: Double? = 0
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                if result.gender == Genders.man.rawValue {
                    let weightBMR = 13.4 * Double(result.weight)
                    let heughtBMR = 4.8 * Double(result.height)
                    let ageBMR = 5.7 * Double(result.age)
                    bmr = 88.36 + (weightBMR) + (heughtBMR) - (ageBMR)
                } else if result.gender == Genders.woman.rawValue {
                    let weightBMR = 9.2 * Double(result.weight)
                    let heughtBMR = 3.1 * Double(result.height)
                    let ageBMR = 4.3 * Double(result.age)
                    bmr = 447.6 + (weightBMR) + (heughtBMR) - (ageBMR)
                }
                
                switch result.levelOfActivity {
                case LevelOfActivityEnum.low.rawValue:
                        bmr = (bmr ?? 0) * 1.2
                    break
                    case LevelOfActivityEnum.middle.rawValue:
                        bmr = (bmr ?? 0) * 1.5
                    break
                    case LevelOfActivityEnum.hight.rawValue:
                        bmr = (bmr ?? 0) * 1.8
                    break
                default:
                    print("error")
                }
                result.reccomendCcal = Int16(bmr ?? 0)
            }
        } catch {
            print(error)
        }
        
        return Int(bmr ?? 0)
    }
}
