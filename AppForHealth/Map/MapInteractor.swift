//
//  MapInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 07.04.2023.
//

import Foundation

protocol MapInteractorProtocol: AnyObject {
    
}

class MapInteractor: MapInteractorProtocol {
    weak var presenter: MapPresenterProtocol?
    
}
