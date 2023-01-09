//
//  AuthorizationPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.12.2022.
//

import UIKit

protocol AuthorizationPresenterProtocol: AnyObject {
    func viewDidLoaded()
    
    
    func didTapDoneButton()
    func didTapDoneButtonFromRegistration()
    
    func didLoad(date: String?)
    
    func didRegistration(name: String, email: String, password: String, presenter: AuthorizationPresenterProtocol?)
    func didEntrance(email: String, password: String, presenter: AuthorizationPresenterProtocol?)
    
    func showAlert(vc: UIViewController)
}

class AuthorizationPresenter {
    weak var view: AuthorizationViewProtocol?
    var router: AuthorizationRouterProtocol
    var interactor: AuthorizationInteractorProtocol
    
    init(interactor: AuthorizationInteractorProtocol, router: AuthorizationRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension AuthorizationPresenter: AuthorizationPresenterProtocol {

    func didTapDoneButton() {
        router.openMain()
    }
    func didTapDoneButtonFromRegistration() {
        if interactor.checkCoreDataIsEmpty() {
            router.openParametrsScreen()
        } else {
            router.openMain()
        }
        
    }
    
    func viewDidLoaded() {
        interactor.loadDate()
    }
    
    func didLoad(date: String?) {
        //view?.showDate(date: date ?? "No data")
    }
    
    func didRegistration(name: String, email: String, password: String, presenter: AuthorizationPresenterProtocol?) {
        interactor.registration(name: name, email: email, password: password, presenter: self)
    }
    
    func didEntrance(email: String, password: String, presenter: AuthorizationPresenterProtocol?) {
        interactor.entranceInAcc(email: email, password: password, presenter: self)
    }
    
    func showAlert(vc: UIViewController) {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        vc.present(alert, animated: true, completion: nil)
    }
}
