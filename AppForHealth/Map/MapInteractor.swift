//
//  MapInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import Foundation
import MapKit

protocol MapInteractorProtocol: AnyObject {
    func fetchPlaces(location: CLLocationCoordinate2D, closure: @escaping ([MKAnnotation]) -> Void)
    func checkAuthorizationLocation(locationManager: CLLocationManager, closure: () -> Void)
}

class MapInteractor {
    weak var presenter: MapPresenterProtocol?
    
}

extension MapInteractor: MapInteractorProtocol {
    func fetchPlaces(location: CLLocationCoordinate2D, closure: @escaping ([MKAnnotation]) -> Void) { // Поиск ближайших спортивных залов
        let searchSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let searchRegion = MKCoordinateRegion(center: location, span: searchSpan)
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.region = searchRegion
        searchRequest.resultTypes = .pointOfInterest
        searchRequest.naturalLanguageQuery = "Fitness"
        
        let search = MKLocalSearch(request: searchRequest)
        
        
        var annotations = [MKAnnotation]()
        
        search.start { response, error in
            guard let mapItems = response?.mapItems else {
                return
            }
            
            let results = mapItems.map({$0.name ?? "No name Found"})
            
            mapItems.forEach { mapItem in
                let annotation = MKPointAnnotation()
                annotation.title = mapItem.placemark.name
                annotation.subtitle = mapItem.placemark.title
                annotation.coordinate = mapItem.placemark.location!.coordinate
                annotations.append(annotation)
            }
            closure(annotations)
            print(results)
        }
    }
    
    func checkAuthorizationLocation(locationManager: CLLocationManager, closure: () -> Void) {
        let status: CLAuthorizationStatus
        if #available(iOS 14, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .authorizedAlways:
            closure()
            break
        case .authorizedWhenInUse:
            closure()
            break
        case .denied:
            presenter?.showAlert(title: "Вы запретили использовать ваше местоположение".localized(), message: "Хотите разрешить?".localized(), url: URL(string: UIApplication.openSettingsURLString))
            //showAlert(title: "Вы запретили использовать ваше местоположение".localized(), message: "Хотите разрешить?".localized(), url: URL(string: UIApplication.openSettingsURLString))
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            print("default")
        }
    }
}
