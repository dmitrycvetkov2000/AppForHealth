//
//  MapVC.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import UIKit
import SnapKit
import MapKit

protocol MapVCProtocol: AnyObject {
    func setMap()
    func configureNavigationItems()
    func checkLocationEnabled()
}

class MapVC: UIViewController {
    var presenter: MapPresenterProtocol?
    
    var leftBarButton = UIButton()
    
    var mapView = MKMapView()
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        presenter?.viewDidLoaded()
        
        let initialLocation = CLLocation(latitude: 52.24, longitude: 54.589998)
        mapView.centerLocation(initialLocation)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppered()
    }
}


extension MapVC: MapVCProtocol {
    
    func fetchPlaces(location: CLLocationCoordinate2D) { // Поиск ближайших спортивных залов
        let searchSpan = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
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
            self.mapView.addAnnotations(annotations)
            print(results)
        }
        
    }
    
    func setMap() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func checkLocationEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.setupLocationManager()
                    self.checkAuthorizationLocation()
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "У вас выключена служба геолокации".localized(), message: "Хотите включить?".localized(), url: URL(string: "App-Prefs:root=LOCATION_SERVICES"))
                }
            }
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkAuthorizationLocation() {
        let status: CLAuthorizationStatus
        if #available(iOS 14, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            fetchPlaces(location: locationManager.location!.coordinate)
            break
        case .denied:
            showAlert(title: "Вы запретили использовать ваше местоположение".localized(), message: "Хотите разрешить?".localized(), url: URL(string: UIApplication.openSettingsURLString))
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            print("default")
        }
    }
    
    func showAlert(title: String, message: String?, url: URL?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Настройки".localized(), style: .default) { (alert) in
            if let url = url {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена".localized(), style: .cancel)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func configureNavigationItems() {
        leftBarButton.translatesAutoresizingMaskIntoConstraints = false
        leftBarButton.clipsToBounds = true
        leftBarButton.widthAnchor.constraint(equalToConstant: 61).isActive = true
        leftBarButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        leftBarButton.layer.cornerRadius = 0.5 * leftBarButton.bounds.size.width
        
        leftBarButton.setBackgroundImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
        leftBarButton.tintColor = .tabBarMainColor
        leftBarButton.addTarget(self, action: #selector(comeback), for: .touchUpInside)
    
        let leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    @objc func comeback() {
        dismiss(animated: true)
    }
}

extension MapVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorizationLocation()
    }
}

extension MKMapView {
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var viewMarker: MKMarkerAnnotationView
        if locationManager.location?.coordinate.latitude != annotation.coordinate.latitude && locationManager.location?.coordinate.longitude != annotation.coordinate.longitude {
            let idView = "marker"
            if let view = mapView.dequeueReusableAnnotationView(withIdentifier: idView) as? MKMarkerAnnotationView {
                view.annotation = annotation
                viewMarker = view
            } else {
                viewMarker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: idView)
                viewMarker.canShowCallout = true
                viewMarker.calloutOffset = CGPoint(x: 0, y: 6)
                viewMarker.rightCalloutAccessoryView = UIButton(type: .infoDark)
            }
            return viewMarker
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let coordinate = locationManager.location?.coordinate else { return }
        
        self.mapView.removeOverlays(mapView.overlays)
        
        let user = view.annotation
        let startPoint = MKPlacemark(coordinate: coordinate)
        let endPoint = MKPlacemark(coordinate: user?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startPoint)
        request.destination = MKMapItem(placemark: endPoint)
        request.transportType = .automobile
        
        let direction = MKDirections(request: request)
        direction.calculate { response, error in
            guard let response = response else { return }
            for route in response.routes {
                self.mapView.addOverlay(route.polyline)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 4
        
        return renderer
    }
}
