//
//  MapModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import UIKit

class MapModuleBuilder: UIViewController {
    
    static func build(usingNavigationFactory factory: NavigationFactory) -> UINavigationController {
        let interactor = MapInteractor()
        let router = MapRouter()
        let presenter = MapPresenter(interactor: interactor, router: router)
        let viewController = MapVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return factory(viewController)
    }
    
}
