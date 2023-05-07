//
//  ThirdInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import Foundation
import Charts
import CoreData

protocol ThirdInteractorProtocol: AnyObject {
    func fillChart()
    
    func getDataForChart() -> LineChartData
    
    func getMaxNumberOfWaterFromBD() -> Int?
    
    func dateFormate(i: Int)
    
    func showMasOfWeek() -> [String]
    
    func getCurDate()
    
    func getLast7Days()
    
    func fillProducts()
}

class ThirdInteractor {
    weak var presenter: ThirdPresenterProtocol?
    
    var entries = [ChartDataEntry]()
    
    var entriesPie = [PieChartDataEntry]()
    
    var weekMas: [String] = []
    
    var curDate: String = ""
}

extension ThirdInteractor: ThirdInteractorProtocol {
    func fillChart() {
        entries.removeAll()
        weekMas = []
        presenter?.getLast7Days()
        
        let dateAndNum: [String: Int16]? = CoreDataManager.instance.getElementFromBD(find: "date")
        if let dateAndNum = dateAndNum {
            for (i, date) in weekMas.indexed() {
                var num: Int16 = 0
                for (key, value) in dateAndNum {
                    if key == date {
                        num = value
                    }
                }
                presenter?.dateFormate(i: i)
                entries.append(ChartDataEntry(x: Double(i), y: Double(num)))
            }
        } else {
            for i in 0..<weekMas.count {
                presenter?.dateFormate(i: i)
                entries.append(ChartDataEntry(x: Double(i), y: Double(0)))
            }
        }
    }
    
    func getDataForChart() -> LineChartData {
        let set = LineChartDataSet(entries: entries)
        set.colors = [UIColor.red]
        
        set.label = "Количество выпитой жидкости".localized()
        
        let data = LineChartData(dataSet: set)
        return data
    }
    
    func getMaxNumberOfWaterFromBD() -> Int? {
        return CoreDataManager.instance.getElementFromBD(find: "reccomendWater")
    }
    
    func getLast7Days() {
        let date = Date()

        for x in (0..<7).reversed() {
            let day = Calendar.current.date(byAdding: .day, value: -x, to: date)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.YYYY"
            formatter.timeZone = TimeZone(secondsFromGMT: 10800)            // указатель временной зоны относительно гринвича
            let formatteddate = formatter.string(from: day! as Date)
            
            weekMas.append(formatteddate)
        }
    }
    
    func showMasOfWeek() -> [String] {
        return weekMas
    }
    
    func getCurDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 10800)            // указатель временной зоны относительно гринвича
        curDate = formatter.string(from: date as Date)
    }
    
    func dateFormate(i: Int) {
        weekMas[i].removeLast(5)
    }
    
    func fillProducts() {
        RealmManager.instance.fillProducts()
    }
}
