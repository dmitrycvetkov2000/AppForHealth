//
//  SecondPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import UIKit
import Charts

protocol SecondPresenterProtocol: AnyObject {
    func setConstraintsForBarChart1()
    func setConstraintsForPieChart1()
    
    func fillChart()
    func fillPieChart()
    
    func getDataForChart() -> BarChartData
    func getDataForPieChart() -> PieChartData
    
    func configureBarChart()
    func configuratePieChart()
    
    func getMaxCcal() -> Int?
    
    func showLimitLine()
    
    func getlastWeek()
    
    func showMasOfWeek() -> [String]
    
    func dateFormate(i: Int)
    
    func getCurDate()
    
    func fillProducts()
    
    func getLast7Days()
}

class SecondPresenter {
    weak var view: SecondVCProtocol?
    var router: SecondRouterProtocol
    var interactor: SecondInteractorProtocol
    
    init(interactor: SecondInteractorProtocol, router: SecondRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension SecondPresenter: SecondPresenterProtocol {
    func setConstraintsForBarChart1() {
        view?.createConstraintsForBarChart1()
    }
    func setConstraintsForPieChart1() {
        view?.createConstraintsForPieChart1()
    }
    
    func fillChart() {
        interactor.fillChart()
    }
    
    func fillPieChart() {
        interactor.fillPieChart()
    }
    
    func getDataForChart() -> BarChartData {
        interactor.getDataForChart()
    }
    
    func getDataForPieChart() -> PieChartData {
        interactor.getDataForPieChart()
    }
    
    func configureBarChart() {
        view?.configurateBarChart()
    }
    func configuratePieChart() {
        view?.configuratePieChart()
    }
    
    func getMaxCcal() -> Int? {
        return interactor.getMaxCcalFromBD()
    }
    
    func showLimitLine() {
        view?.createLimiteLine()
    }
    
    func getlastWeek() {
        interactor.getLast7Days()
    }
    
    func showMasOfWeek() -> [String] {
        interactor.showMasOfWeek()
    }
    
    func dateFormate(i: Int) {
        interactor.dateFormate(i: i)
    }
    
    func getCurDate() {
        interactor.getCurDate()
    }
    
    func fillProducts() {
        interactor.fillProducts()
    }
    
    func getLast7Days() {
        interactor.getLast7Days()
    }
}
