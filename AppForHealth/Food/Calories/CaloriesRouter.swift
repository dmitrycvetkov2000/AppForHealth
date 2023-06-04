//
//  CaloriesRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 25.02.2023.
//

import Foundation

protocol CaloriesRouterProtocol: AnyObject {
    func openFindFoodVC()
}

class CaloriesRouter: CaloriesRouterProtocol {
    weak var viewController: CaloriesVC?
    
    
    func openFindFoodVC() {
        let vc = FindFoodModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        viewController?.present(vc, animated: true)
    }
}
