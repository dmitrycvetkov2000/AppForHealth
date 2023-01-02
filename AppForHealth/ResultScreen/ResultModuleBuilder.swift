//
//  ResultModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 19.12.2022.
//

import UIKit

class ResultModuleBuilder: UIViewController {
    
    static func build() -> ResultVC {
        let interactor = ResultInteractor()
        let router = ResultRouter()
        let presenter = ResultPresenter(interactor: interactor, router: router)
        let viewController = ResultVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
    
}
