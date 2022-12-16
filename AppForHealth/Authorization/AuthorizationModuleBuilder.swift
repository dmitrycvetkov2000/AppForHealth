//
//  AuthorizationModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.12.2022.
//

import UIKit

class AuthorizationModuleBuilder: UIViewController {
    static func build() -> ViewController {
        let interactor = AuthorizationInteractor()
        let router = AuthorizationRouter()
        let presenter = AuthorizationPresenter(interactor: interactor, router: router)
        let viewController = ViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
