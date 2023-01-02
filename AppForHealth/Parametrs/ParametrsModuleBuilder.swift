//
//  ParametrsModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 18.12.2022.
//

import UIKit

class ParametrsModuleBuilder: UIViewController {
    
    static func build() -> ParametrsVC {
        let interactor = ParametrsInteractor()
        let router = ParametrsRouter()
        let presenter = ParametrsPresenter(interactor: interactor, router: router)
        let viewController = ParametrsVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
    
}
