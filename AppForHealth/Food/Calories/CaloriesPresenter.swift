//
//  CaloriesPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 25.02.2023.
//

import Foundation

protocol CaloriesPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didTapFindFoodVCButton()
    
    func updateProgressView()
    
    func increaseProgres(percentOfProt: Double, percentOfFats: Double, percentOfCarb: Double, percentOfCcal: Float)
    
    func setLimitLabelsTexts(maxProt: Double, maxFats: Double, maxCarb: Double, maxCcal: Double)
    
    func setLabelsTexts(percentOfProt: Double, percentOfFats: Double, percentOfCarb: Double, percentOfCcal: Float, countProt: Double, countFats: Double, countCarb: Double, countCcal: Double)
    
    func determeMaxValuesProtFatsCarbs(array: [ProductToday])
}

class CaloriesPresenter {
    weak var view: CaloriesVCProtocol?
    var router: CaloriesRouterProtocol
    var interactor: CaloriesInteractorProtocol
    
    init(interactor: CaloriesInteractorProtocol, router: CaloriesRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}
extension CaloriesPresenter: CaloriesPresenterProtocol {
    func viewDidLoaded() {
        view?.createButtonForCalendar()
        view?.createStackForStatistics()
        view?.createButtonForAddFood()
        view?.createTableViewForFood()
    }
    
    func didTapFindFoodVCButton() {
        router.openFindFoodVC()
    }
    
    func updateProgressView() {
        view?.updateProgressView()
    }
    
    func increaseProgres(percentOfProt: Double, percentOfFats: Double, percentOfCarb: Double, percentOfCcal: Float) {
        view?.increaseProgres(percentOfProt: percentOfProt, percentOfFats: percentOfFats, percentOfCarb: percentOfCarb, percentOfCcal: percentOfCcal)
    }
    
    func setLimitLabelsTexts(maxProt: Double, maxFats: Double, maxCarb: Double, maxCcal: Double) {
        view?.setLimitLabelsTexts(maxProt: maxProt, maxFats: maxFats, maxCarb: maxCarb, maxCcal: maxCcal)
    }
    
    func setLabelsTexts(percentOfProt: Double, percentOfFats: Double, percentOfCarb: Double, percentOfCcal: Float, countProt: Double, countFats: Double, countCarb: Double, countCcal: Double) {
        view?.setLabelsTexts(percentOfProt: percentOfProt, percentOfFats: percentOfFats, percentOfCarb: percentOfCarb, percentOfCcal: percentOfCcal, countProt: countProt, countFats: countFats, countCarb: countCarb, countCcal: countCcal)
    }
    
    func determeMaxValuesProtFatsCarbs(array: [ProductToday]) {
        interactor.determeMaxValuesProtFatsCarbs(array: array)
    }
}
