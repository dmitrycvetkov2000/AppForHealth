//
//  RecipesInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 28.12.2022.
//

import Foundation

protocol RecipesInteractorProtocol: AnyObject {
    
}

class RecipesInteractor: RecipesInteractorProtocol {
    weak var presenter: RecipesPresenterProtocol?
}

