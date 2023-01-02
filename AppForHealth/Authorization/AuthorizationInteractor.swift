//
//  AuthorizationInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.12.2022.
//

import Foundation

protocol AuthorizationInteractorProtocol: AnyObject {
    func loadDate()
    
    func registration(name: String, email: String, password: String, presenter: AuthorizationPresenterProtocol?)
    
    func entranceInAcc(email: String, password: String, presenter: AuthorizationPresenterProtocol?)
    
    func checkCoreDataIsEmpty() -> Bool
}

class AuthorizationInteractor: AuthorizationInteractorProtocol {
    
    weak var presenter: AuthorizationPresenterProtocol?
    
    let firebaseService = FirebaseService()
    
    func loadDate() {
        self.presenter?.didLoad(date: "21.20.2922")
    }
    
    func registration(name: String, email: String, password: String, presenter: AuthorizationPresenterProtocol?) {
        firebaseService.registration(name: name, email: email, password: password, presenter: presenter)
    }
    
    func entranceInAcc(email: String, password: String, presenter: AuthorizationPresenterProtocol?) {
        firebaseService.entrance(email: email, password: password, presenter: presenter)
    }
    
    func checkCoreDataIsEmpty() -> Bool {
        return CoreDataManager.instance.isEmptyCoreData()
    }
}
