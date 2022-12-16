//
//  AuthorizationInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.12.2022.
//

import Foundation

protocol AuthorizationInteractorProtocol: AnyObject {
    func loadDate()
}

class AuthorizationInteractor: AuthorizationInteractorProtocol {
    weak var presenter: AuthorizationPresenterProtocol?
    
    func loadDate() {
        self.presenter?.didLoad(date: "21.20.2922")
    }
}
