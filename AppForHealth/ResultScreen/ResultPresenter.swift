//
//  ResultPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 19.12.2022.
//

import Foundation

protocol ResultPresenterProtocol: AnyObject {
    func didTapOkButton()
}

class ResultPresenter {
    
    weak var view: ResultVCProtocol?
    var router: ResultRouterProtocol
    var interactor: ResultInteractorProtocol
    
    init(interactor: ResultInteractorProtocol, router: ResultRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension ResultPresenter: ResultPresenterProtocol {
    func didTapOkButton() {
        router.openMain()
    }
    
    
}
