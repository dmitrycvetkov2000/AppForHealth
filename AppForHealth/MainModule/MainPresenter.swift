//
//  MainPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    
    func didTapRecipesButton()
    func didTapWaterButton()
    func didTapSettingsButton()
}

class MainPresenter {
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol
    var interactor: MainInteractorProtocol
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
extension MainPresenter: MainPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    func didTapRecipesButton() {
        router.openRecipes()
    }
    
    func didTapWaterButton() {
        router.openWater()
    }
    
    func didTapSettingsButton() {
        router.openSettings()
    }
    
}
