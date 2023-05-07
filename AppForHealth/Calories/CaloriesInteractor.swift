//
//  CaloriesInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 25.02.2023.
//

import Foundation

protocol CaloriesInteractorProtocol: AnyObject {
    
}

class CaloriesInteractor: CaloriesInteractorProtocol {
    weak var presenter: CaloriesPresenterProtocol?
    
}
