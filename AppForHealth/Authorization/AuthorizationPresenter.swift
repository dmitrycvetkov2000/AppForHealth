//
//  AuthorizationPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 14.12.2022.
//

import Foundation

protocol AuthorizationPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didTapDoneButton()
    func didLoad(date: String?)
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
    
    
    func viewDidLoaded() {
        interactor.loadDate()
    }
    
    func didLoad(date: String?) {
        view?.showDate(date: date ?? "No data")
    }
}
