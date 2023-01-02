//
//  RecipesPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 28.12.2022.
//

import Foundation

protocol RecipesPresenterProtocol: AnyObject {
    
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
    
}
