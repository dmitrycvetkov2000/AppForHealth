//
//  WaterInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 08.01.2023.
//

import UIKit
import CoreData

protocol WaterInteractorProtocol: AnyObject {
    func incWater(label: UILabel) -> Int16
    func saveData(label: UILabel)
    
    func countingNumberML() -> Int16?
    
    func getCurDate()
}

class WaterInteractor: WaterInteractorProtocol {
    weak var presenter: WaterPresenterProtocol?
    
    var numberML: Int16? = 0
    
    var date: [String: Int16]?
    
    var curDate: String = ""
    
    @discardableResult func incWater(label: UILabel) -> Int16 {
        numberML! += 100
        label.text = "\(numberML ?? 0) " + "мл".localized()
        return numberML ?? 0
    }
    
    func countingNumberML() -> Int16? {
        date = CoreDataManager.instance.getElementFromBD(find: "date")
        
        print("New value = \(String(describing: date?[curDate])), curDate = \(curDate)")
        if let data = date {
            numberML = data[curDate]
        } else {
            numberML = 0
            self.date = [curDate: 0]
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
            do {
                let results = try CoreDataManager.instance.context.fetch(fetchRequest)
                for result in results as! [Person] {
                    if DefaultsManager.instance.defaults.string(forKey: "token") == result.token {
                        result.numberOfWater = numberML ?? 0
                        result.date = self.date
                    }
                }
            } catch {
                print(error)
            }
            CoreDataManager.instance.saveContext()
        }
        return numberML
    }
    
    func saveData(label: UILabel) {
        numberML = date?[curDate]
        if numberML != nil {
            self.numberML! += 100
        } else {
            self.numberML = 100
            date?[curDate] = numberML
        }
        
        label.text = "\(numberML ?? 0) " + "мл".localized()
        print("CurDate = \(curDate)")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                if DefaultsManager.instance.defaults.string(forKey: "token") == result.token {
                    result.numberOfWater = numberML ?? 0
                    if (result.date?[curDate]) != nil {
                        date?[curDate] = numberML
                        result.date?[curDate]! = numberML ?? 0
                    } else {
                        result.date = date
                    }
                }
            }
        } catch {
            print(error)
        }
        CoreDataManager.instance.saveContext()
    }

    func getCurDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 10800)            // указатель временной зоны относительно гринвича
        curDate = formatter.string(from: date as Date)
    }
    
}
