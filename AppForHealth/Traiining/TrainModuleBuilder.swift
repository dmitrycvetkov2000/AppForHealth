//
//  TrainModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.04.2023.
//

import UIKit

class TrainModuleBuilder: UIViewController {
    
    static func build(usingNavigationFactory factory: NavigationFactory) -> UINavigationController {
        let interactor = TrainInteractor()
        let router = TrainRouter()
        let presenter = TrainPresenter(interactor: interactor, router: router)
        let viewController = TrainVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return factory(viewController)
    }
}

