//
//  SettingRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 09.01.2023.
//

import Foundation

protocol SettingRouterProtocol: AnyObject {
    func openFirstScreen()
}

class SettingRouter: SettingRouterProtocol {
    weak var viewController: SettingVC?
    
    func openFirstScreen() {
        let vc = AuthorizationModuleBuilder.build()
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true)
    }
}
