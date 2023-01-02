//
//  ParametrsPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 18.12.2022.
//

import UIKit

protocol ParametrsPresenterProtocol: AnyObject {
    func didTappedSaveButton(ageTextField: UITextField, gender: String, goal: String, heightTextField: UITextField, levelOfActivity: String, weightTextField: UITextField)
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
    func didTappedSaveButton(ageTextField: UITextField, gender: String, goal: String, heightTextField: UITextField, levelOfActivity: String, weightTextField: UITextField) {
        interactor.writeParametersToBD(ageTextField: ageTextField, gender: gender, goal: goal, heightTextField: heightTextField, levelOfActivity: levelOfActivity, weightTextField: weightTextField)
        router.openResults()
    }
    
}
