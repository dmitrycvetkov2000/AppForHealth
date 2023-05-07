//
//  WaterPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 08.01.2023.
//

import UIKit
//import CoreData

protocol WaterPresenterProtocol: AnyObject {
    func viewDidLoaded()
    
    func configureNavigationItems()
    
    func countingTheAmountOfWater() -> Int16?
    
    func showViewForAnimation()
    
    func setupCup()
    
    func getMainPartOfCup() -> CAShapeLayer
    func getBackPartOfCup() -> CAShapeLayer
    func getHandlePartOfCup() -> CAShapeLayer
    
    func startAnimation()
    
    func saveDataAndIncWater(label: UILabel)
    
    func getCurDate()
    
    func didTapLeftButton()
}

class WaterPresenter {
    
    weak var view: WaterVCProtocol?
    var router: WaterRouterProtocol
    var interactor: WaterInteractorProtocol
    
    init(interactor: WaterInteractorProtocol, router: WaterRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension WaterPresenter: WaterPresenterProtocol {
    func viewDidLoaded() {
        
    }
    
    func countingTheAmountOfWater() -> Int16? {
        return interactor.countingNumberML()
    }
    
    func showViewForAnimation() {
        view?.createViewForAnimation()
    }
    
    func getMainPartOfCup() -> CAShapeLayer {
        view?.createMainPartOfCup() ?? CAShapeLayer()
    }
    
    func getBackPartOfCup() -> CAShapeLayer {
        view?.createBackPartOfCup() ?? CAShapeLayer()
    }
    
    func getHandlePartOfCup() -> CAShapeLayer {
        view?.createHandlePartOfCup() ?? CAShapeLayer()
    }
    
    func setupCup() {
        view?.setupCup()
    }
    
    func startAnimation() {
        view?.startAnimation()
    }
    
    func saveDataAndIncWater(label: UILabel) {
        interactor.saveData(label: label)
    }

    func getCurDate() {
        interactor.getCurDate()
    }
    
    func configureNavigationItems() {
        view?.configureNavigationItems()
    }
    
    func didTapLeftButton() {
        router.openMain()
    }
}
