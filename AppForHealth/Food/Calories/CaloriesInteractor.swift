//
//  CaloriesInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 25.02.2023.
//

import Foundation
import CoreData

protocol CaloriesInteractorProtocol: AnyObject {
    func determeMaxValuesProtFatsCarbs(array: [ProductToday])
}

class CaloriesInteractor {
    weak var presenter: CaloriesPresenterProtocol?
    
    var maxCcal: Double = 0.0
    var maxProt: Double = 0.0
    var maxFats: Double = 0.0
    var maxCarb: Double = 0.0
    
    var countProt: Double = 0.0
    var countFats: Double = 0.0
    var countCarb: Double = 0.0
    var countCcal: Double = 0.0
    
    var percentOfProt: Double = 0.0
    var percentOfFats: Double = 0.0
    var percentOfCarb: Double = 0.0
    var percentOfCcal: Double = 0.0
}

extension CaloriesInteractor: CaloriesInteractorProtocol {
    func determeMaxValuesProtFatsCarbs(array: [ProductToday]) {
        maxCcal = 0
        var goal: String = ""
        var gender: String = ""
        var multiForProt: Double = 0.0
        var multiForFats: Double = 0.0
        var multiForCarb: Double = 0.0

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                if DefaultsManager.instance.defaults.string(forKey: "token") == result.token {
                    maxCcal = Double(result.reccomendCcal)
                    goal = result.goal ?? ""
                    gender = result.gender ?? ""
                }
            }
        } catch {
            print(error)
        }

        switch goal {
        case Goals.norma.rawValue:
            if gender == Genders.man.rawValue {
                    multiForProt = 0.3
                    multiForFats = 0.3
                    multiForCarb = 0.4
            } else if gender == Genders.woman.rawValue {
                    multiForProt = 0.3
                    multiForFats = 0.3
                    multiForCarb = 0.4
                }
                break
        case Goals.weightUp.rawValue:
                if gender == Genders.man.rawValue {
                    multiForProt = 0.2
                    multiForFats = 0.2
                    multiForCarb = 0.6
                } else if gender == Genders.woman.rawValue {
                    multiForProt = 0.3
                    multiForFats = 0.2
                    multiForCarb = 0.5
                }
        case Goals.leaveWeight.rawValue:
                if gender == Genders.man.rawValue {
                    multiForProt = 0.6
                    multiForFats = 0.1
                    multiForCarb = 0.3
                } else if gender == Genders.woman.rawValue {
                    multiForProt = 0.5
                    multiForFats = 0.2
                    multiForCarb = 0.3
                }
        default:
            print("error")
        }

        maxProt = multiForProt * Double(maxCcal)
        maxFats = multiForFats * Double(maxCcal)
        maxCarb = multiForCarb * Double(maxCcal)
        
        countProt = 0.0
        countFats = 0.0
        countCarb = 0.0
        countCcal = 0.0
        
        incCountsOfProtFatsCarbs(array: array)
        determePercents()
        
        presenter?.increaseProgres(percentOfProt: percentOfProt, percentOfFats: percentOfFats, percentOfCarb: percentOfCarb, percentOfCcal: Float(percentOfCcal))
        presenter?.setLimitLabelsTexts(maxProt: maxProt, maxFats: maxFats, maxCarb: maxCarb, maxCcal: maxCcal)
        presenter?.setLabelsTexts(percentOfProt: percentOfProt, percentOfFats: percentOfFats, percentOfCarb: percentOfCarb, percentOfCcal: Float(percentOfCcal), countProt: countProt, countFats: countFats, countCarb: countCarb, countCcal: countCcal)
    }
    
    func incCountsOfProtFatsCarbs(array: [ProductToday]) {        
        for product in array {
            countProt += product.proteins
            countFats += product.fats
            countCarb += product.carb
            countCcal += Double(product.ccal)
        }
    }
    
    func determePercents() {
        percentOfProt = countProt / maxProt
        percentOfFats = countFats / maxFats
        percentOfCarb = countCarb / maxCarb
        percentOfCcal = countCcal / maxCcal
    }
}


