//
//  AuthorizationInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.12.2022.
//

import Foundation
import UIKit

protocol AuthorizationInteractorProtocol: AnyObject {
    
    func registration(name: String, email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView)
    
    func entranceInAcc(email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView)
    
    func checkCoreDataIsEmpty() -> Bool
}

class AuthorizationInteractor: AuthorizationInteractorProtocol {
    
    weak var presenter: AuthorizationPresenterProtocol?
    
    let firebaseService = FirebaseService()
    
    
    func registration(name: String, email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView) {
        firebaseService.registration(name: name, email: email, password: password, presenter: presenter, vc: vc, spinner: spinner, blurEffectView: blurEffectView)
    }
    
    func entranceInAcc(email: String, password: String, presenter: AuthorizationPresenterProtocol?, vc: UIViewController, spinner: CustomSpinnerSimple, blurEffectView: UIVisualEffectView) {
        firebaseService.entrance(email: email, password: password, presenter: presenter, vc: vc, spinner: spinner, blurEffectView: blurEffectView)
    }
    
    func checkCoreDataIsEmpty() -> Bool {
        return CoreDataManager.instance.isEmptyCoreData()
    }
}
