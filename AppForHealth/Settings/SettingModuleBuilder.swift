//
//  SettingModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 09.01.2023.
//

import UIKit

class SettingModuleBuilder: UIViewController {
    
    static func build(usingNavigationFactory factory: NavigationFactory) -> UINavigationController {
        let interactor = SettingInteractor()
        let router = SettingRouter()
        let presenter = SettingPresenter(interactor: interactor, router: router)
        let viewController = SettingVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return factory(viewController)
    }
}
