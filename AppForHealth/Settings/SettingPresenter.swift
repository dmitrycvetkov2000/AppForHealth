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
    
    
    func viewDidLoaded()
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
    func didTapOnExitButton() {
        router.openFirstScreen()
    }
    
    func didExit() {
        interactor.signOut()
    }
    
    
    func viewDidLoaded() {

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
        
        
        
    }
}
