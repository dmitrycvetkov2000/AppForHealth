//
//  MapPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import MapKit

protocol MapPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func viewDidAppered()
    
    func fetchPlaces(location: CLLocationCoordinate2D, closure: @escaping ([MKAnnotation]) -> Void)
    func showAlert(title: String, message: String?, url: URL?)
    func checkAuthorizationLocation(locationManager: CLLocationManager, closure: () -> Void)
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
    
    func fetchPlaces(location: CLLocationCoordinate2D, closure: @escaping ([MKAnnotation]) -> Void) {
        interactor.fetchPlaces(location: location, closure: closure)
    }
    
    func showAlert(title: String, message: String?, url: URL?) {
        view?.showAlert(title: title, message: message, url: url)
    }
    
    func checkAuthorizationLocation(locationManager: CLLocationManager, closure: () -> Void) {
        interactor.checkAuthorizationLocation(locationManager: locationManager, closure: closure)
    }
}
