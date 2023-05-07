//
//  AuthorizationRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.12.2022.
//

import Foundation
import UIKit

protocol AuthorizationRouterProtocol: AnyObject {
    func openMain()
    func openParametrsScreen()
}
class AuthorizationRouter: AuthorizationRouterProtocol {

    weak var viewController: ViewController?
    
    func openMain() {
        let vc = MainTabBarModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true)
    }
    
    func openParametrsScreen() {
        let vc = ParametrsModuleBuilder.build()
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true)
    }
    
}
