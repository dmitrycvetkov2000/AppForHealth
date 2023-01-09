//
//  WaterModuleBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 08.01.2023.
//

import UIKit

class WaterModuleBuilder: UIViewController {
    
    static func build() -> WaterVC {
        let interactor = WaterInteractor()
        let router = WaterRouter()
        let presenter = WaterPresenter(interactor: interactor, router: router)
        let viewController = WaterVC()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
    
}
