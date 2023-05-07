//
//  RecipesModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 28.12.2022.
//

import UIKit

class RecipesModuleBuilder: UIViewController {
    
    static func build(usingNavigationFactory factory: NavigationFactory) -> UINavigationController {
        let interactor = RecipesInteractor()
        let router = RecipesRouter()
        let presenter = RecipesPresenter(interactor: interactor, router: router)
        let viewController = RecipesVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return factory(viewController)
    }
}
