//
//  OnboardPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import UIKit

protocol OnboardPresenterProtocol: AnyObject {
    func didTappedLastButton()
}

class OnboardPresenter {
    weak var view: OnboardPageVCProtocol?
    var router: OnboardRouterProtocol
    var interactor: OnboardInteractorProtocol
    
    init(interactor: OnboardInteractorProtocol, router: OnboardRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension OnboardPresenter: OnboardPresenterProtocol {
    func didTappedLastButton() {
        router.openAuthorization()
    }
}
