//
//  AddFoodRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import Foundation

protocol AddFoodRouterProtocol: AnyObject {
    func openFindFood()
    func openCaloriesVC()
}
class AddFoodRouter: AddFoodRouterProtocol {
    weak var viewController: AddFoodVC?
    
    func openFindFood() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func openCaloriesVC() {
        viewController?.dismiss(animated: true)
    }
}
