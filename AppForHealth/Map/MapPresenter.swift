//
//  MapPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import Foundation

protocol MapPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func viewDidAppered()
}

class MapPresenter {
    weak var view: MapVCProtocol?
    var router: MapRouterProtocol
    var interactor: MapInteractorProtocol
    
    init(interactor: MapInteractorProtocol, router: MapRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension MapPresenter: MapPresenterProtocol {
    
    func viewDidLoaded() {
        view?.configureNavigationItems()
        view?.setMap()
    }
    
    func viewDidAppered() {
        view?.checkLocationEnabled()
    }
}
