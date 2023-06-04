//
//  FindFoodModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import UIKit

class FindFoodModuleBuilder: UIViewController {
    static func build(usingNavigationFactory factory: NavigationFactory) -> UINavigationController {
        let interactor = FindFoodInteractor()
        let router = FindFoodRouter()
        let presenter = FindFoodVCPresenter(interactor: interactor, router: router)
        let viewController = FindFoodVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return factory(viewController)
    }
}
