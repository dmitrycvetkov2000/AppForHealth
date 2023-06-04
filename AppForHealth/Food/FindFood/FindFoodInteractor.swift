//
//  FindFoodInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import Foundation

protocol FindFoodInteractorProtocol: AnyObject {
    
}

class FindFoodInteractor: FindFoodInteractorProtocol {
    weak var presenter: FindFoodVCPresenterProtocol?
}
