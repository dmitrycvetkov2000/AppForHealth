//
//  MainTabBarPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import Foundation

protocol MainTabBarPresenterProtocol: AnyObject {
    func didTapRecipesButton()
    func didTapWaterButton()
    func didTapSettingsButton()
    func didTapCaloriesButton()
    func didTapMapButton()
    func didTapTrainButton()
    
    func HideSideMenu()
    
    func setSwipeRecognizer1()
    func setSwipeRecognizer2()
    func setTapRecognizer()
    
}

class MainTabBarPresenter {
    weak var view: MainTabBarProtocol?
    var router: MainTabBarRouterProtocol
    var interactor: MainTabBarInteractorProtocol
    
    init(interactor: MainTabBarInteractorProtocol, router: MainTabBarRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MainTabBarPresenter: MainTabBarPresenterProtocol {
    func didTapRecipesButton() {
        router.openRecipes()
    }
    
    func didTapWaterButton() {
        router.openWater()
    }
    
    func didTapSettingsButton() {
        router.openSettings()
    }
    func didTapCaloriesButton() {
        router.openCalories()
    }
    func didTapMapButton() {
        router.openMap()
    }
    func didTapTrainButton() {
        router.openTrain()
    }
    
    func HideSideMenu() {
        view?.HideSideMenu()
    }
    
    func setSwipeRecognizer1() {
        view?.setSwipeRecognizer1()
    }
    
    func setSwipeRecognizer2() {
        view?.setSwipeRecognizer2()
    }
    
    func setTapRecognizer() {
        view?.setTapRecognizer()
    }
}
