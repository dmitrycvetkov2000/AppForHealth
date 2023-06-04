//
//  MoreInformationPresenter.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import Foundation

protocol MoreInformationPresenterProtocol: AnyObject {
    
}
class MoreInformationPresenter {
    weak var view: MoreInformationVCProtocol?
    var router: MoreInformationRouterProtocol
    var interactor: MoreInformationInteractorProtocol
    
    init(interactor: MoreInformationInteractorProtocol, router: MoreInformationRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}
extension MoreInformationPresenter: MoreInformationPresenterProtocol {
    
}
