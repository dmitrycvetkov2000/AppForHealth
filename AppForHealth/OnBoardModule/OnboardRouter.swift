//
//  OnboardRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import Foundation

protocol OnboardRouterProtocol: AnyObject {
    func openAuthorization()
}

class OnboardRouter: OnboardRouterProtocol {
    
    weak var viewController: OnboardVC?
    
    func openAuthorization() {
        let vc = AuthorizationModuleBuilder.build()
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true)
    }
    
}
