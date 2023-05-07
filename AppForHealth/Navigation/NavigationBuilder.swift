//
//  NavigationBuilder.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 16.03.2023.
//

import UIKit

typealias NavigationFactory = (UIViewController) -> (UINavigationController)

class NavigationBuilder {
    static func build(rootView: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootView)
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }
}
