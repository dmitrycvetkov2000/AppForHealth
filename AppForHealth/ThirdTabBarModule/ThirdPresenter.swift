//
//  ThirdPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import Foundation
import Charts

protocol ThirdPresenterProtocol: AnyObject {
    func setConstraintsForLineChart1()
    
    func fillChart()
    
    func getDataForChart() -> LineChartData
    
    func configureLineChart()
    
    func getMaxNumberOfWater() -> Int?
    
    func showLimitLine()
    
    func getlastWeek()
    
    func showMasOfWeek() -> [String]
    
    func dateFormate(i: Int)
    
    func fillProducts()
    
    func getCurDate()
    
    func getLast7Days()
}

class ThirdPresenter {
    weak var view: ThirdVCProtocol?
    var router: ThirdRouterProtocol
    var interactor: ThirdInteractorProtocol
    
    init(interactor: ThirdInteractorProtocol, router: ThirdRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ThirdPresenter: ThirdPresenterProtocol {
    
    func setConstraintsForLineChart1() {
        view?.createConstraintsForLineChart1()
    }
    
    func fillChart() {
        interactor.fillChart()
    }
    
    func getDataForChart() -> LineChartData {
        interactor.getDataForChart()
    }
    
    func configureLineChart() {
        view?.configurateLineChart()
    }
    
    func getMaxNumberOfWater() -> Int? {
        return interactor.getMaxNumberOfWaterFromBD()
    }
    
    func showMasOfWeek() -> [String] {
        interactor.showMasOfWeek()
    }
    
    func showLimitLine() {
        view?.createLimiteLine()
    }
    
    
    func dateFormate(i: Int) {
        interactor.dateFormate(i: i)
    }
    
    func fillProducts() {
        interactor.fillProducts()
    }
    
    func getCurDate() {
        interactor.getCurDate()
    }
    
    func getlastWeek() {
        interactor.getLast7Days()
    }
    
    func getLast7Days() {
        interactor.getLast7Days()
    }
}
