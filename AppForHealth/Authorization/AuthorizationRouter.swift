//
//  AuthorizationRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.12.2022.
//

import Foundation

protocol AuthorizationRouterProtocol: AnyObject {
    func openMain()
}
class AuthorizationRouter: AuthorizationRouterProtocol {
    weak var viewController: ViewController?
    func openMain() {
        let vc = MainModuleBuilder.build()
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true)
    }
}
