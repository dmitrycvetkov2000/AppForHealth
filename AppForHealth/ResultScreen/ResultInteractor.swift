//
//  ResultInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 19.12.2022.
//

import Foundation

protocol ResultInteractorProtocol: AnyObject {
    
}

class ResultInteractor: ResultInteractorProtocol {
    weak var presenter: ResultPresenterProtocol?
}
