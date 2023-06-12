//
//  AddFoodPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import Foundation
protocol AddFoodPresenterProtocol: AnyObject {
    func didTapBackButton()
    func didTapCancelButton()
    
    func fillTextFields(res: Double, prot: Double, fat: Double, carb: Double, ccal: Double)
    func findMultiple(weight: Double)
}
class AddFoodPresenter {
    weak var view: AddFoodVCProtocol?
    var router: AddFoodRouterProtocol
    var interactor: AddFoodInteractorProtocol
    
    init(interactor: AddFoodInteractorProtocol, router: AddFoodRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension AddFoodPresenter: AddFoodPresenterProtocol {
    func didTapBackButton() {
        router.openFindFood()
    }
    
    func didTapCancelButton() {
        router.openCaloriesVC()
    }
    
    func fillTextFields(res: Double, prot: Double, fat: Double, carb: Double, ccal: Double) {
        view?.fillTextFields(res: res, prot: prot, fat: fat, carb: carb, ccal: ccal)
    }
    
    func findMultiple(weight: Double) {
        interactor.findMultiple(weight: weight)
    }
}
