//
//  MainTabBarRouter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import Foundation

protocol MainTabBarRouterProtocol: AnyObject {
    func openFirstScreen()
    func openRecipes()
    func openWater()
    func openSettings()
    func openCalories()
    func openMap()
    func openTrain()
}

class MainTabBarRouter: MainTabBarRouterProtocol {
    weak var viewController: MainTabBarVC?
    
    func openFirstScreen() {
        let vc = AuthorizationModuleBuilder.build()
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true)
    }
    
    func openRecipes() {
        let vc = RecipesModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        viewController?.present(vc, animated: true)
    }
    
    func openWater() {
        let vc = WaterModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        viewController?.present(vc, animated: true)
    }
    
    func openSettings() {
        let vc = SettingModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        viewController?.present(vc, animated: true)
    }
    func openCalories() {
        let vc = CaloriesModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        viewController?.present(vc, animated: true)
    }
    func openMap() {
        let vc = MapModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        viewController?.present(vc, animated: true)
    }
    func openTrain() {
        let vc = TrainModuleBuilder.build(usingNavigationFactory: NavigationBuilder.build)
        viewController?.present(vc, animated: true)
    }
}
