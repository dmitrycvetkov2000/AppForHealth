//
//  TrainRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.04.2023.
//

import Foundation

protocol TrainRouterProtocol: AnyObject {
    func dismiss()
}

class TrainRouter: TrainRouterProtocol {
    weak var viewController: TrainVC?
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
