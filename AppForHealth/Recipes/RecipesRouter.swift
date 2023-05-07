//
//  RecipesRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 28.12.2022.
//

import Foundation

protocol RecipesRouterProtocol: AnyObject {
    func openMain()
}

class RecipesRouter: RecipesRouterProtocol {
    weak var viewController: RecipesVC?
    
    func openMain() {
        viewController?.dismiss(animated: true)
    }
}
