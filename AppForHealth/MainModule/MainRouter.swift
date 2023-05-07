//
//  MainRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import Foundation
import  UIKit

protocol MainRouterProtocol: AnyObject {
    func openRecipes()
    func openWater()
    func openTrain()
    func openCcal()
    func openMap()
    func openSetting()
}

class MainRouter {
    weak var viewController: MainViewController?
}

extension MainRouter: MainRouterProtocol {
    func openRecipes() {
        let vc = RecipesModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        viewController?.present(vc, animated: true)
    }
    func openWater() {
        let vc = WaterModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        viewController?.present(vc, animated: true)
    }
    func openTrain() {
        let vc = TrainModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        viewController?.present(vc, animated: true)
    }
    func openCcal() {
        let vc = CaloriesModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        viewController?.present(vc, animated: true)
    }
    func openMap() {
        let vc = MapModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        viewController?.present(vc, animated: true)
    }
    func openSetting() {
        let vc = SettingModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        viewController?.present(vc, animated: true)
    }
}
