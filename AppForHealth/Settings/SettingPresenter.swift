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
    
    func settingValues(mas: inout [String])
    
    func viewDidLoaded(mas: inout [String])
    
    func showAlert()
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
    
    func settingValues(mas: inout [String]) {
        interactor.extractionFromBD(mas: &mas)
    }
    
    
    func viewDidLoaded(mas: inout [String]) {

        view?.settingValuesFromBD(mas: &mas)
        
        view?.addScrollView()
        view?.addLabelForGender()
        view?.addStackViewForGender()
        
        view?.createLabelForAgeHeightAndWeight()
        view?.createStackViewForAgeHeightAndWeightTextFields()
        
        view?.createLabelOfActivity()
        view?.createStackViewForActivity()
        
        view?.createLabelForGoal()
        view?.createStackViewForGoal()
        
        view?.createButtonForExit()
        view?.createConstraintsForButtonForExit()
        
        view?.createButtonForSave()
        
    }
}
