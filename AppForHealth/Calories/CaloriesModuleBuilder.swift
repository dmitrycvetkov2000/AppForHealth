//
//  CaloriesModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 25.02.2023.
//

import UIKit

class CaloriesModuleBuilder: UIViewController {
    static func build(usingNavigationFactory factory: NavigationFactory) -> UINavigationController {
        let interactor = CaloriesInteractor()
        let router = CaloriesRouter()
        let presenter = CaloriesPresenter(interactor: interactor, router: router)
        let viewController = CaloriesVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return factory(viewController)
    }
}
