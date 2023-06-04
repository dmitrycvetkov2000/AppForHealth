//
//  MoreInformationModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import UIKit

class MoreInformationModuleBuilder: UIViewController {
    static func build() -> MoreInformationVC {
        let interactor = MoreInformationInteractor()
        let router = MoreInformationRouter()
        let presenter = MoreInformationPresenter(interactor: interactor, router: router)
        let viewController = MoreInformationVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
