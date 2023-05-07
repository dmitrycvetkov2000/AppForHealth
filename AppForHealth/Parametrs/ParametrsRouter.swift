//
//  ParametrsRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 18.12.2022.
//

import Foundation

protocol ParametrsRouterProtocol: AnyObject {
    func openMain()
}

class ParametrsRouter: ParametrsRouterProtocol {
    weak var viewController: ParametrsVC?
    
    func openMain() {
        let vc = MainTabBarModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true)
    }
    
}
