//
//  SecondInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import UIKit
import Charts
import RealmSwift

protocol SecondInteractorProtocol: AnyObject {
    func fillChart()
    func fillPieChart()
    
    func getDataForChart() -> BarChartData
    func getDataForPieChart() -> PieChartData
    
    func getMaxCcalFromBD() -> Int?
    
    func getLast7Days()
    
    func showMasOfWeek() -> [String]
    
    func dateFormate(i: Int)
    
    func getCurDate()
    
    func fillProducts()
}

class SecondInteractor {
    weak var presenter: SecondPresenterProtocol?
    
    var entries = [BarChartDataEntry]()
    
    var entriesPie = [PieChartDataEntry]()
    
    var weekMas: [String] = []
    
    var curDate: String = ""
}
extension SecondInteractor: SecondInteractorProtocol {
    func fillChart() {
        entries.removeAll()
        weekMas = []
        presenter?.getLast7Days()
        
        if let products = RealmManager.instance.products {
            for (i, date) in weekMas.indexed() {
                var sumCcal = 0
                for prod in products {
                    if DefaultsManager.instance.defaults.string(forKey: "token") == prod.token {
                        if prod.date == date {
                            sumCcal += prod.ccal
                        }
                    }
                }
                presenter?.dateFormate(i: i)
                entries.append(BarChartDataEntry(x: Double(i), y: Double(sumCcal)))
            }
        }
    }
    
    func fillPieChart() {
        entriesPie.removeAll()
        if let products = RealmManager.instance.products {
            var sumProteins: Double = 0
            var sumFats: Double = 0
            var sumCarb: Double = 0
            for prod in products {
                if prod.date == curDate {
                    if DefaultsManager.instance.defaults.string(forKey: "token") == prod.token {
                        sumProteins += prod.proteins
                        sumFats += prod.fats
                        sumCarb += prod.carb
                    }
                }
            }
            
            entriesPie.append(PieChartDataEntry(value: Double(sumProteins), label: "Белки".localized(), data: "Протеины".localized()))
            entriesPie.append(PieChartDataEntry(value: Double(sumFats), label: "Жиры".localized(), data: "Жиры".localized()))
            entriesPie.append(PieChartDataEntry(value: Double(sumCarb), label: "Углеводы".localized(), data: "Углеводы".localized()))
        }
    }
    
    func getDataForChart() -> BarChartData {
        let set = BarChartDataSet(entries: entries)
        set.colors = [UIColor.red]
        set.label = "Количество калорий".localized()
        
        let data = BarChartData(dataSet: set)
        return data
    }
    
    func getDataForPieChart() -> PieChartData {
        let set = PieChartDataSet(entries: entriesPie)
        set.colors = ChartColorTemplates.material()
        set.label = ""
        let data = PieChartData(dataSet: set)
        return data
    }
    
    func getMaxCcalFromBD() -> Int? {
        return CoreDataManager.instance.getElementFromBD(find: "reccomendCcal")
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
    
    func getCurDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 10800)            // указатель временной зоны относительно гринвича
        curDate = formatter.string(from: date as Date)
    }
    
    func showMasOfWeek() -> [String] {
        return weekMas
    }
    
    func dateFormate(i: Int) {
        weekMas[i].removeLast(5)
    }
    
    func fillProducts() {
        RealmManager.instance.fillProducts()
    }
}

