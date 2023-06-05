//
//  AddFoodModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import UIKit

class AddFoodModuleBuilder: UIViewController {
    static func build() -> AddFoodVC {
        let interactor = AddFoodInteractor()
        let router = AddFoodRouter()
        let presenter = AddFoodPresenter(interactor: interactor, router: router)
        let viewController = AddFoodVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
