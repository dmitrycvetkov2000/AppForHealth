//
//  WaterInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 08.01.2023.
//

import Foundation

protocol WaterInteractorProtocol: AnyObject {
    
}

class WaterInteractor: WaterInteractorProtocol {
    weak var presenter: WaterPresenterProtocol?
    
}
