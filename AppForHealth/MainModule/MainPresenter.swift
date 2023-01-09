//
//  MainPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapExitButton()
    func didExit()
    
    func didTapRecipesButton()
    func didTapWaterButton()
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
    func didTapExitButton() {
        router.openFirstScreen()
    }
    
    func didExit() {
        interactor.signOut()
    }
    
    func didTapRecipesButton() {
        print("Presenter BBBBBBB")
        router.openRecipes()
    }
    
    func didTapWaterButton() {
        router.openWater()
    }
    
}
