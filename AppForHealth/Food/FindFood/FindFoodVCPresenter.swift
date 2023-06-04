//
//  FindFoodVCPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import Foundation

protocol FindFoodVCPresenterProtocol: AnyObject {
    func didTapReturnButton()
    func didTapAddButton()
}

class FindFoodVCPresenter {
    weak var view: FindFoodVCProtocol?
    var router: FindFoodRouterProtocol
    var interactor: FindFoodInteractorProtocol
    
    init(interactor: FindFoodInteractorProtocol, router: FindFoodRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension FindFoodVCPresenter: FindFoodVCPresenterProtocol {
    func didTapReturnButton() {
        router.openCaloriesVC()
    }
    
    func didTapAddButton() {
        router.openAddFoodVC()
    }
}
