//
//  SettingInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 09.01.2023.
//

import Foundation

protocol SettingInteractorProtocol: AnyObject {
    func signOut()
}

class SettingInteractor: SettingInteractorProtocol {
    weak var presenter: SettingPresenterProtocol?
    
    let firebaseService = FirebaseService()
    
    func signOut() {
        firebaseService.signOutFromAcc(presenter: presenter)
    }
}
