//
//  MoreInformationInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 04.06.2023.
//

import Foundation

protocol MoreInformationInteractorProtocol: AnyObject {
    
}
class MoreInformationInteractor: MoreInformationInteractorProtocol {
    weak var presenter: MoreInformationPresenterProtocol?
}
