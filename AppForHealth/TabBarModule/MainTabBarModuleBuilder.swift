//
//  MainTabBarModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import UIKit

class MainTabBarModuleBuilder: UIViewController {
    static func build(usingNavigationFactory factory: NavigationFactory) -> UINavigationController {
        let interactor = MainTabBarInteractor()
        let router = MainTabBarRouter()
        let presenter = MainTabBarPresenter(interactor: interactor, router: router)
        let viewController = MainTabBarVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return factory(viewController)
    }
}
