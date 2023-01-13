//
//  SettingInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 09.01.2023.
//

import Foundation

protocol SettingInteractorProtocol: AnyObject {
    func signOut() -> Bool
}

class SettingInteractor: SettingInteractorProtocol {
    weak var presenter: SettingPresenterProtocol?
    
    let firebaseService = FirebaseService()
    
    func signOut() -> Bool {
        firebaseService.signOutFromAcc(presenter: presenter)
        return true
    }
}
