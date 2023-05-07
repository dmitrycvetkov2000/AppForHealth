//
//  OnboardInteractor.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 15.12.2022.
//

import Foundation

protocol OnboardInteractorProtocol: AnyObject {

}

class OnboardInteractor: OnboardInteractorProtocol {
    
    weak var presenter: OnboardPresenterProtocol?
    
}
