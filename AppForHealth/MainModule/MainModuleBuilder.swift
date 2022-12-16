//
//  MainModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import UIKit

class MainModuleBuilder: UIViewController {
    static func build() -> MainViewController {
        let interactor = MainInteractor()
        let router = MainRouter()
        let presenter = MainPresenter(interactor: interactor, router: router)
        let viewController = MainViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
