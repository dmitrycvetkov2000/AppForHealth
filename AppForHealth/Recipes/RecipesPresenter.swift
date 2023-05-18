//
//  RecipesPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 28.12.2022.
//

import Foundation

protocol RecipesPresenterProtocol: AnyObject {
    func setNavigationItems()
    func didTapLeftButton()
    
    func setBlurEffect()
    func setSpinnerAndStart()
    func removeSpinnerAndBlurEffect()
    
    func getRequest(helper: HelperForRecipes, type: ApiType)
    
    func reloadCollectView()
}

class RecipesPresenter {
    weak var view: RecipesVCProtocol?
    var router: RecipesRouterProtocol
    var interactor: RecipesInteractorProtocol
    
    init(interactor: RecipesInteractorProtocol, router: RecipesRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension RecipesPresenter: RecipesPresenterProtocol {
    func setNavigationItems() {
        view?.configureNavigationItems()
    }
    
    func didTapLeftButton() {
        router.openMain()
    }
    
    func setBlurEffect() {
        view?.setBlurEffect()
    }
    
    func setSpinnerAndStart() {
        view?.setSpinnerAndStart()
    }
    
    func removeSpinnerAndBlurEffect() {
        view?.removeSpinnerAndBlurEffect()
    }
    
    func getRequest(helper: HelperForRecipes, type: ApiType) {
        interactor.getRequest(helper: helper, type: type)
    }
    
    func reloadCollectView() {
        view?.reloadCollectView()
    }
}
