//
//  MainPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoaded()
    
    func showMainLabel()
    
    func showGenderAgeLabel() -> String
    func showHeightWeightBodyFatLabel() -> String
    func showIMTLabel() -> String
    func showReccomendCaloriesLabel() -> String
    func showRecomendWaterLabel() -> String
    func getData<T>(name: String) -> T?
    
    func determSmile(imt: String) -> String
    
    func tapOnRecipes()
    func tapOnWater()
    func tapOnTrain()
    func tapOnCcal()
    func tapOnMap()
    func tapOnSetting()
}

class MainPresenter {
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol
    var interactor: MainInteractorProtocol
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
extension MainPresenter: MainPresenterProtocol {
    func viewDidLoaded() {
        showMainLabel()
    }
    
    func showMainLabel() {
        view?.createMainLabel()
    }
    
    func showGenderAgeLabel() -> String {
        return view?.createGenderAgeLabel() ?? ""
    }
    
    func showIMTLabel() -> String {
        return view?.createIMTLabel() ?? ""
    }
    
    func showHeightWeightBodyFatLabel() -> String {
        return view?.createHeightWeightBodyFatLabel() ?? ""
    }
    
    func getData<T>(name: String) -> T? {
        return interactor.getData(name: name)
    }
    
    func determSmile(imt: String) -> String {
        return interactor.checkIMTAndDetermSmile(imt: imt)
    }
    
    func showReccomendCaloriesLabel() -> String {
        return view?.createReccomendCaloriesLabel() ?? ""
    }
    
    func showRecomendWaterLabel() -> String {
        return view?.createRecomendWaterLabel() ?? ""
    }
    
    func tapOnRecipes() {
        router.openRecipes()
    }
    func tapOnWater() {
        router.openWater()
    }
    func tapOnTrain() {
        router.openTrain()
    }
    func tapOnCcal() {
        router.openCcal()
    }
    func tapOnMap() {
        router.openMap()
    }
    func tapOnSetting() {
        router.openSetting()
    }
}
