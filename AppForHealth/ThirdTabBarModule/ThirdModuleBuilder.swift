//
//  ThirdModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import UIKit

class ThirdModuleBuilder: UIViewController {
    static func build() -> UIViewController {
        let interactor = ThirdInteractor()
        let router = ThirdRouter()
        let presenter = ThirdPresenter(interactor: interactor, router: router)
        let viewController = ThirdVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
