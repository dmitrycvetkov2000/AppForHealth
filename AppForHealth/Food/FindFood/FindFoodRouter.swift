//
//  FindFoodRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import Foundation

protocol FindFoodRouterProtocol: AnyObject {
    func openCaloriesVC()
    func openAddFoodVC()
}
class FindFoodRouter: FindFoodRouterProtocol {
    weak var viewController: FindFoodVC?
    
    func openCaloriesVC() {
        viewController?.dismiss(animated: true)
    }
    
    func openAddFoodVC() {
        let vc = AddFoodModuleBuilder.build()
        viewController?.navigationController?.pushViewController(vc, animated: true)
        //viewController?.present(vc, animated: true)
    }
}
