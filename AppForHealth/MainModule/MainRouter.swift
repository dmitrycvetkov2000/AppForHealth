//
//  MainRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import Foundation
import  UIKit

protocol MainRouterProtocol: AnyObject {
    func openFirstScreen()
    func openRecipes()
}

class MainRouter: MainRouterProtocol {
    var handler: UIViewController?
    
    weak var viewController: MainViewController?
    
    func openFirstScreen() {
        let vc = AuthorizationModuleBuilder.build()
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true)
    }
    
    func openRecipes() {
        let vc = RecipesModuleBuilder.build()
        vc.modalPresentationStyle = .fullScreen
        print("EEEEERRRRRR")
        viewController?.present(vc, animated: true)
    }
}
