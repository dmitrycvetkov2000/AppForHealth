//
//  ParametrsPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 18.12.2022.
//

import UIKit

protocol ParametrsPresenterProtocol: AnyObject {
    func didTappedSaveButton(age: String, gender: String, goal: String, height: String, levelOfActivity: String, weight: String)
    func setTapRecognizer()
    
    func createViewForHello()
}

class ParametrsPresenter {
    weak var view: ParametrsVCProtocol?
    var router: ParametrsRouterProtocol
    var interactor: ParametrsInteractorProtocol
    
    
    init(interactor: ParametrsInteractorProtocol, router: ParametrsRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension ParametrsPresenter: ParametrsPresenterProtocol {
    func didTappedSaveButton(age: String, gender: String, goal: String, height: String, levelOfActivity: String, weight: String) {
        interactor.writeParametersToBD(age: age, gender: gender, goal: goal, height: height, levelOfActivity: levelOfActivity, weight: weight)
        
        interactor.calculateAndSaveNumberOfWater()
        interactor.culculationAndSaveIMT()
        interactor.culculationCalories()
        
        interactor.saveAllResults()
        
        router.openMain()
    }
    
    func setTapRecognizer() {
        view?.setTapRecognizer()
    }
    
    func createViewForHello() {
        view?.createViewForHello()
    }
    
}
