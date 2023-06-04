//
//  AddFoodInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import Foundation

protocol AddFoodInteractorProtocol: AnyObject {
    
}
class AddFoodInteractor: AddFoodInteractorProtocol {
    weak var presenter: AddFoodPresenterProtocol?
}
