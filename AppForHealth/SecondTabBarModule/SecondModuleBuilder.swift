//
//  SecondModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import UIKit

class SecondModuleBuilder: UIViewController {
    static func build() -> UIViewController {
        let interactor = SecondInteractor()
        let router = SecondRouter()
        let presenter = SecondPresenter(interactor: interactor, router: router)
        let viewController = SecondVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
