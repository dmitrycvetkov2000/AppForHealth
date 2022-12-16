//
//  MainInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    
}

class MainInteractor: MainInteractorProtocol{
    weak var presenter: MainPresenterProtocol?
}
