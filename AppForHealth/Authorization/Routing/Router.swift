//
//  Router.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 26.05.2023.
//

import VK_ios_sdk
import UIKit

enum Route {
    case authorization(appId: String)
}

class Router {
    private weak var rootViewController: UIViewController?

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    func route(to route: Route) {
        switch route {
        case .authorization(let appId):
            let viewController = AuthorizationViewController(
                authorizationService: AuthorizationService(appId: appId),
                router: self
            )
            self.present(viewController: viewController)
        }
    }

    private weak var presentedViewController: UIViewController?

    private func present(viewController: UIViewController) {
        guard let rootViewController = self.rootViewController else { return }
        self.presentedViewController?.vk_removeFromParent()
        rootViewController.vk_addSubview(from: viewController)
        viewController.view.frame = rootViewController.view.bounds
    }
}

extension UIViewController {
    func vk_addSubview(from controller: UIViewController) {
        self.vk_addChild(childController: controller)
        self.view.addSubview(controller.view)
    }

    func vk_addChild(childController: UIViewController) {
        assert(childController.parent == nil, "Remove controller from other container first")
        // willMove(toParent:) automatically called within addChild()
        self.addChild(childController)
        childController.didMove(toParent: self)
    }

    func vk_removeFromParent() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        // didMove(toParent:) automatically called withing removeFromParent()
    }
}
