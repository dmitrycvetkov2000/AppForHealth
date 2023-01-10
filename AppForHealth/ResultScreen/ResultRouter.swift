//
//  ResultRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 19.12.2022.
//

import Foundation

protocol ResultRouterProtocol: AnyObject {
    func openMain()
}

class ResultRouter: ResultRouterProtocol {
    weak var viewController: ResultVC?
    
    func openMain() {
        let vc = MainModuleBuilder.build()
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true)
    }
}
