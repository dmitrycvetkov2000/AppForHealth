//
//  CaloriesPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 25.02.2023.
//

import Foundation

protocol CaloriesPresenterProtocol: AnyObject {
    func viewDidLoaded()
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
        view?.createCalendar()
        view?.createButtonForCloseCalendar()
        view?.createStackForStatistics()
        view?.createTableViewForFood()
        view?.createButtonForAddFood()
    }
}
