//
//  SettingPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 09.01.2023.
//

import Foundation

protocol SettingPresenterProtocol: AnyObject {
    
    func didTapOnExitButton()
    func didExit()
    
    func didTapOnSaveButton(gender: String, age: String, weight: String, height: String, levelOfActivity: String, goal: String)
    
    func viewDidLoaded()
    
    func showAlert()
    
    func getElement<T>(elementName: String) -> T?
    
    func didTapOnBackButton()
}

class SettingPresenter {
    weak var view: SettingVCProtocol?
    var router: SettingRouterProtocol
    var interactor: SettingInteractorProtocol
    
    init(interactor: SettingInteractorProtocol, router: SettingRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension SettingPresenter: SettingPresenterProtocol {
    func showAlert() {
        view?.showAlertAboutSave()
    }
    
    func didTapOnExitButton() {
        router.openFirstScreen()
    }
    
    func didExit() {
        interactor.signOut()
    }
    
    func didTapOnSaveButton(gender: String, age: String, weight: String, height: String, levelOfActivity: String, goal: String) {
        interactor.writeParametrsInBD(gender: gender, age: age, weight: weight, height: height, levelOfActivity: levelOfActivity, goal: goal)
    }
    
    func viewDidLoaded() {
        view?.configureNavifationItems()
        view?.setupLayout()
        
        view?.addLabelForGender()
        view?.addStackViewForGender()
        
        view?.createLabelForAgeHeightWeightAndWaist()
        view?.createStackViewForAgeHeightAndWeightTextFields()
        
        view?.createLabelOfActivity()
        view?.createStackViewForActivity()
        
        view?.createLabelForGoal()
        view?.createStackViewForGoal()
        
        view?.createButtonForSave()
        
        view?.createButtonForExit()
        view?.createConstraintsForButtonForExit()
    }
    
    func getElement<T>(elementName: String) -> T? {
        interactor.getElement(elementName: elementName)
    }
    
    func didTapOnBackButton() {
        router.openMain()
    }
}
