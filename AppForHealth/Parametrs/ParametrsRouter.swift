//
//  ParametrsRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 18.12.2022.
//

import Foundation

protocol ParametrsRouterProtocol: AnyObject {
    func openResults()
}

class ParametrsRouter: ParametrsRouterProtocol {
    
    weak var viewController: ParametrsVC?
    
    func openResults() {
        let vc = ResultModuleBuilder.build()
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true)
    }
    
}
