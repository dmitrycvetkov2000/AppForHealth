//
//  OnboardModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import UIKit

class OnboardModuleBuilder: UIViewController {
    
    static func build() -> OnboardVC {
        let interactor = OnboardInteractor()
        let router = OnboardRouter()
        let presenter = OnboardPresenter(interactor: interactor, router: router)
        let viewController = OnboardVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
    
}
