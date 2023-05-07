//
//  WaterRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 08.01.2023.
//

import Foundation

protocol WaterRouterProtocol: AnyObject {
    func openMain()
}

class WaterRouter: WaterRouterProtocol {
    weak var viewController: WaterVC?
    
    func openMain() {
        viewController?.dismiss(animated: true)
    }
}
